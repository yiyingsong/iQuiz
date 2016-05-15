//
//  answerViewController.swift
//  iQuiz
//
//  Created by apple on 5/13/16.
//  Copyright © 2016 Sophie. All rights reserved.
//

import UIKit

class answerViewController: UIViewController {

    @IBOutlet weak var finished: UIButton!
    @IBOutlet weak var next: UIButton!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var firstLine: UILabel!
    @IBOutlet weak var secondLine: UILabel!
    var questionList = []
    var userChoice : String = ""
    var answer : String = ""
    var points : Int = 0
    var quizNum : Int = 0
    var questionText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog(userChoice);
        NSLog(answer);
        if (userChoice == answer) {
            secondLine.text = "You chose the right answer!";
            points = points + 1;
        } else {
            secondLine.text = "Ops, " + userChoice +  " is not the correct answer";
        }
        
        firstLine.text = answer
        self.question.text = questionText
        if (quizNum == questionList.count - 1) {
            next.enabled = false;
            finished.enabled = true;
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "nextSegue") {
            let questionView : questionViewController = segue.destinationViewController as! questionViewController;
            questionView.points = points
            questionView.quizNumber = quizNum + 1
            questionView.questionList = questionList
        } else {
            let questionView : resultViewController = segue.destinationViewController as! resultViewController;
            questionView.questions = points
            questionView.totalScore = quizNum + 1
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
