
//
//  ViewController.swift
//  iQuiz
//
//  Created by apple on 5/5/16.
//  Copyright © 2016 Sophie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var items: [String] =  ["Mathematics", "Marvel Super Heros", "Science"]
    var itemsDescr: [String] = ["Can you do Math", "Here comes the superheros", "Keep learning"]
    var pics = ["math.png", "superhero.png", "science.png" ]

    var mathQ = []
    var scienceQ = []
    var marvelQ = []
    
    var url = "https://tednewardsandbox.site44.com/questions.json"
    
    @IBAction func Setting(sender: UIBarButtonItem) {
        
        let alertController = UIAlertController.init(title: "Settings", message: "Update JSON File", preferredStyle: .Alert)
        let cancel = UIAlertAction(title:"Cancel", style:.Default) {(action) in }
        alertController.addAction(cancel)
        let updateAction = UIAlertAction(title:"Check Now", style:.Default, handler: {
            alert -> Void in
            self.url = alertController.textFields![0].text!
            self.online(self.url)
            //self.setNeedsFocusUpdate()
        })
        
        alertController.addAction(updateAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.text = "https://tednewardsandbox.site44.com/questions.json"
        }
        
        alertController.view.setNeedsLayout()
        self.presentViewController(alertController, animated: true) {
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        offline("/Users/apple/Desktop/INFO498/iQuizRest/iQuiz/iQuiz/downloaded.json")
        online("http://tednewardsandbox.site44.com/questions.json")
    }
    
    func offline(getPath : String) {
        do {
            let data = try NSData(contentsOfFile: getPath, options: .DataReadingMappedIfSafe);
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            if let jsonObject = (json as? NSArray){
                var i = 0
                for quiz in jsonObject {
                    let singleT = quiz["title"] as! String
                    self.items[i] = singleT
                    let singleD = quiz["desc"] as! String
                    self.itemsDescr[i] = singleD
                    switch singleT {
                    case "Marvel Super Heroes":
                        self.marvelQ = quiz["questions"] as! [AnyObject]
                    case "Science!":
                        self.scienceQ = quiz["questions"] as! [AnyObject]
                    case "Mathematics":
                        self.mathQ = quiz["questions"] as! [AnyObject]
                    default:
                        print("Question load failed!")
                    }
                    i = i+1
                }
            }
        } catch {
            print(error)
            print("Question load failed!")
        }
        
    }
    
    func online (getUrl : String) {
        let requestURL: NSURL = NSURL(string: getUrl)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        httpGet(urlRequest) { (data, error) -> Void in
            if error != nil {
                print(error)
            } else {
                let raw = data.dataUsingEncoding(NSUTF8StringEncoding);
                let file = NSFileManager.defaultManager();
                file.createFileAtPath("/Users/apple/Desktop/INFO498/iQuizRest/iQuiz/iQuiz/downloaded.json", contents: raw, attributes: nil)
                do{
                    let converted = data.dataUsingEncoding(NSUTF8StringEncoding)
                    let json = try NSJSONSerialization.JSONObjectWithData(converted!, options: .AllowFragments)
                    if let jsonObject = (json as? NSArray){
                        var i = 0
                        for quiz in jsonObject {
                            let oneTitle = quiz["title"] as! String;
                            self.items[i] = oneTitle
                            let oneDescr = quiz["desc"] as! String;
                            self.itemsDescr[i] = oneDescr
                            switch oneTitle {
                            case "Marvel Super Heroes":
                                self.marvelQ = quiz["questions"] as! [AnyObject]
                            case "Science!":
                                self.scienceQ = quiz["questions"] as! [AnyObject]
                            case "Mathematics":
                                self.mathQ = quiz["questions"] as! [AnyObject]
                            default:
                                print("Questions retrival failed!")
                            }
                            i = i + 1
                        }
                    }
                    
                } catch {
                    print("Error with Json: \(error)")
                }
            }
        }

    }
    
    func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) {
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in if error != nil {
                callback("", error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding: NSASCIIStringEncoding)!;
                callback(result as String, nil)
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = items[indexPath.row]
        cell.detailTextLabel?.text = itemsDescr[indexPath.row]
        let image = pics[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(image)")
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let questionView : questionViewController = storyboard?.instantiateViewControllerWithIdentifier("question") as! questionViewController;
        switch indexPath.row {
        case 0:
            questionView.questionList = scienceQ
        case 1:
            questionView.questionList = marvelQ
        case 2:
            questionView.questionList = mathQ
        default:
            print("Questions did not pass successfully!")
        }
        questionView.quizNumber = 0;
        self.navigationController?.pushViewController(questionView, animated: true);

    }


}

