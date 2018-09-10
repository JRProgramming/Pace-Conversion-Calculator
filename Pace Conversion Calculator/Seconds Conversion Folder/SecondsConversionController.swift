//
//  SecondsConversionController.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/24/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import UIKit

class SecondsConversionController: UIViewController, timePickerView {
    var time: (hour: Int, minute: Int, second: Int) = (0, 0, 0)
    var pickerView = UIPickerView()
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(format: "%02d", row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: time.hour = row
        case 1: time.minute = row
        case 2: time.second = row
        default: break
        }
        let hour = String(format: "%02d", time.hour)
        let minute = String(format: "%02d", time.minute)
        let second = String(format: "%02d", time.second)
        timeTextField.text = "\(hour):\(minute):\(second)"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 24
        } else {
            return 60
        }
    }
    
    
    var svm = secondsConversion()
    @IBOutlet weak var secondsOnlyTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var submitButtons: [UIButton]!
    @IBAction func submitButtonAction(_ sender: UIButton) {
        if sender == submitButtons[0] {
            timeLabel.text = svm.convertSecondsIntoTimeFormat(seconds: Int(secondsOnlyTextField.text ?? "0")!)
        } else {
            timeLabel.text = svm.convertTimeFormatIntoSeconds(hour: time.hour, minute: time.minute, second: time.second)
        }
        resignPickerView()
    }
    @IBOutlet weak var timeTextField: UITextField!
    @IBAction func timeTextFieldAction(_ sender: UITextField) {
        timeTextField.resignFirstResponder()
        UIPickerView.transition(with: pickerView, duration: 0.4, options: [], animations: {
            self.pickerView.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: -self.pickerView.frame.size.height)
            self.timeTextField.text = "00:00:00"
        }, completion: nil)
    }
    @IBAction func secondTextFieldAction(_ sender: UITextField) {
        resignPickerView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        resignPickerView()
        view.endEditing(true)
    }
    
    func resignPickerView() {
        if pickerView.frame.origin == CGPoint(x: 0.0, y: view.frame.size.height-pickerView.frame.size.height) {
            UIPickerView.transition(with: pickerView, duration: 0.4, options: [], animations: {
                self.pickerView.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: self.pickerView.frame.size.height)
            }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerViewRect = CGRect(x: 0, y: view.frame.size.height, width: view.frame.size.width, height: 216)
        pickerView = UIPickerView(frame: pickerViewRect)
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(pickerView)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
