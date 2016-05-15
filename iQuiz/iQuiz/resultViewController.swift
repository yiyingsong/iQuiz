//
//  resultViewController.swift
//  iQuiz
//
//  Created by apple on 5/13/16.
//  Copyright © 2016 Sophie. All rights reserved.
//

import UIKit

class resultViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var text: UILabel!
    var questions = 0
    var totalScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        result.text = ("You got \(questions) out of \(totalScore) questions right.")
        let amount = questions - totalScore
        
        if amount == 0 {
            text.text = "Wow, you got a perferct score!"
            
        } else if amount == 1 || amount == 2 {
            text.text = "Great job, play again!"
            
        } else if amount == 3 {
            text.text = "Not bad!"
            
        } else {
            text.text = "Come on, you can do better!"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
