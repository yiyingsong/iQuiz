//
//  questionViewController.swift
//  iQuiz
//
//  Created by apple on 5/13/16.
//  Copyright © 2016 Sophie. All rights reserved.
//

import UIKit

class questionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var quizTitle: UILabel!
    @IBOutlet weak var options: UIPickerView!

    var quizNumber : Int = 0;
    var userChoice : String = "";
    var questionList = [];
    var questions : [String] = [];
    var answers : [[AnyObject]] = [];
    var correctAnswer : [String] = [];
    var points : Int = 0;
    
    override func viewDidLoad() {
        self.options.dataSource = self;
        self.options.delegate = self;
        super.viewDidLoad()
        for question in questionList {
            let answer = question["answer"] as! String;
            correctAnswer.append(answer);
            let options = question["answers"] as! [AnyObject];
            answers.append(options);
            let quesTitle = question["text"] as! String;
            questions.append(quesTitle)
        }
        quizTitle.text = questions[quizNumber]
        let ua = answers[quizNumber] as NSArray
        let uas = ua[0] as! String
        userChoice = uas
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let ua = answers[quizNumber] as NSArray;
        let uas = ua[row] as! String;
        userChoice = uas;
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let qn = answers[quizNumber] as NSArray;
        let qrn = qn.count;
        return qrn;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let ua = answers[quizNumber] as NSArray;
        let uas = ua[row] as! String;
        return uas;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let answerView : answerViewController = segue.destinationViewController as! answerViewController;
        answerView.userChoice = userChoice;
        let thisAnswer = Int(correctAnswer[quizNumber]);
        let thisQuiz = answers[quizNumber] as NSArray;
        let thisQuizAnswer = thisQuiz[thisAnswer! - 1] as! String;
        answerView.answer = thisQuizAnswer;
        answerView.points = points;
        answerView.quizNum = quizNumber;
        answerView.questionList = questionList
        answerView.questionText = questions[quizNumber]
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
