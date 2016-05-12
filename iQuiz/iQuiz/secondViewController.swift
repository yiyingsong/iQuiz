//
//  secondViewController.swift
//  iQuiz
//
//  Created by apple on 5/11/16.
//  Copyright © 2016 Sophie. All rights reserved.
//

import UIKit

class secondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker2: UIPickerView!
    var options = ["Spiderman", "Antman", "Deadpool"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker2.dataSource = self
        self.picker2.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return options[row]
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
        
    }

}
