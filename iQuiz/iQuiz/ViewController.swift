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
    var itemsDescr: [String] = ["Can you do Math", "Here comes the superheros", "Something incredible is waiting to be known"]
    var pics = ["math.png", "superhero.png", "science.png" ]
    
    @IBAction func Setting(sender: UIBarButtonItem) {
        let setting = UIAlertController(title: "Alert", message: "Settings go here", preferredStyle: UIAlertControllerStyle.Alert)
        setting.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(setting, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
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
        
    }


}

