//
//  RaceConversionController.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/24/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import UIKit

class RaceConversionController: UIViewController, timePickerView {
    var time: (hour: Int, minute: Int, second: Int) = (0, 0, 0)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
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
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 24
        } else {
            return 60
        }
    }
    
    var model = RaceConversion()
    var raceDistanceUnit = defaultDistanceUnit
    var newRaceDistanceUnit = defaultDistanceUnit
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var distanceTextfield: UITextField!
    @IBOutlet weak var newRaceDistanceTextField: UITextField!
    @IBOutlet var distanceUnitSegmentedControllers: [UISegmentedControl]!
    @IBAction func distanceConverterSegmentedController(_ sender: UISegmentedControl) {
        if distanceUnitSegmentedControllers.index(of: sender) == 0 {
            switch sender.selectedSegmentIndex {
            case 0: raceDistanceUnit = distanceUnit.miles
            case 1: raceDistanceUnit = distanceUnit.kilometers
            default: break
            }
        } else {
            switch sender.selectedSegmentIndex {
            case 0: newRaceDistanceUnit = distanceUnit.miles
            case 1: newRaceDistanceUnit = distanceUnit.kilometers
            default: break
            }
        }
    }
    var pickerView = UIPickerView()
    @IBAction func timeTextFieldAction(_ sender: UITextField) {
        timeTextField.resignFirstResponder()
        UIPickerView.transition(with: pickerView, duration: 0.4, options: [], animations: {
            self.pickerView.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: -self.pickerView.frame.size.height)
            self.timeTextField.text = "00:00:00"
        }, completion: nil)
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBAction func submitButton(_ sender: UIButton) {
        if let textOriginalDistance = distanceTextfield.text, let originalDistance = Double(textOriginalDistance), let textConvertedDistance = newRaceDistanceTextField.text, let convertedDistance = Double(textConvertedDistance) {
            print(originalDistance)
            print(raceDistanceUnit)
            print(convertedDistance)
            print(newRaceDistanceUnit)
        timeLabel.text = model.convertDistance(hour: time.hour, minute: time.minute, second: time.second, originalDistance: (originalDistance, raceDistanceUnit), convertedDistance: (convertedDistance, newRaceDistanceUnit))
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
        for index in distanceUnitSegmentedControllers.indices {
            distanceUnitSegmentedControllers[index].selectedSegmentIndex = defaultDistanceUnit.index
        }
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
