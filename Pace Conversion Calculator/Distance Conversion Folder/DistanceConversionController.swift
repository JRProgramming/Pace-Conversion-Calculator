//
//  ViewController.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/24/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import UIKit

class distanceConversionView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
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
    
    
    var time: (hour: Int, minute: Int, second: Int) = (0, 0, 0)
    var pickerView = UIPickerView()
    
    var originalDistanceUnit = distanceUnit.miles
    var convertedDistanceUnit = distanceUnit.miles
    var dvm = distanceConversion()
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var originalDistance: UITextField!
    @IBOutlet weak var convertedDistanceTextField: UITextField!
    @IBOutlet weak var convertedTimeLabel: UILabel!
    @IBOutlet var distanceUnitSegmentedControllers: [UISegmentedControl]!
    @IBAction func distanceUnitSegmentedController(_ sender: UISegmentedControl) {
        if distanceUnitSegmentedControllers.index(of: sender) == 0 {
            switch sender.selectedSegmentIndex {
            case 0: originalDistanceUnit = .miles
            case 1: originalDistanceUnit = .kilometers
            default: break
            }
        } else {
            switch sender.selectedSegmentIndex {
            case 0: convertedDistanceUnit = .miles
            case 1: convertedDistanceUnit = .kilometers
            default: break
            }
        }
        resignPickerView()
    }
    @IBAction func distanceTextFieldAction(_ sender: UITextField) {
        resignPickerView()
    }
    
    
    @IBAction func timeTextFieldPickerViewController(_ sender: UITextField) {
        timeTextField.resignFirstResponder()
        UIPickerView.transition(
        with: pickerView,
        duration: 0.4,
        animations: {
            self.pickerView.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: -self.pickerView.frame.size.height)
            self.timeTextField.text = "00:00:00"
        },
        completion: nil)
    }
    @IBAction func doneButton(_ sender: UIButton) {
        if let textOriginalDistance = originalDistance.text, let originalDistance = Double(textOriginalDistance) {
            convertedTimeLabel.text = dvm.convertDistance(hour: time.hour, minute: time.minute, second: time.second, originalDistance: (originalDistance, originalDistanceUnit), convertedDistance: (Double(convertedDistanceTextField.text!) ?? 1, convertedDistanceUnit))
            resignPickerView()
        }
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
        // Do any additional setup after loading the view, typically from a nib.
        for index in distanceUnitSegmentedControllers.indices {
            distanceUnitSegmentedControllers[index].selectedSegmentIndex = defaultDistanceUnit.index
        }
        let pickerViewRect = CGRect(x: 0, y: view.frame.size.height, width: view.frame.size.width, height: 216)
        pickerView = UIPickerView(frame: pickerViewRect)
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(pickerView)
    }
}
