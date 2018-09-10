//
//  recordWorkoutController.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/24/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import UIKit



class RecordIntervalWorkoutController: UIViewController, UITableViewDelegate, UITableViewDataSource, timePickerView {
    
    var time = (hour: 0, minute: 0, second: 0)
    
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
    
    var pickerView = UIPickerView()

    var saveWorkout = recordWorkout()
    var numberOfRows = Int()
    @IBOutlet weak var tableView: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as! recordTableViewCell
        cell.lapLabel.text = "Interval \(indexPath.row + 1)"
        cell.distanceLabel.text = saveWorkout.distanceArray[indexPath.row] + " \(saveWorkout.distanceUnitArray[indexPath.row])"
        cell.timeLabel.text = saveWorkout.timeArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            saveWorkout.removeInterval(at: indexPath.row)
            numberOfRows -= 1
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            
        }
    }
    
    var distance = defaultDistanceUnit
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var distanceTextfield: UITextField!
    @IBOutlet var distanceUnitSegmentedController: UISegmentedControl!
    @IBAction func distanceTextFieldAction(_ sender: UITextField) {
        resignPickerView()
    }
    @IBAction func distanceConverterSegmentedController(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: distance = distanceUnit.miles
        case 1: distance = distanceUnit.kilometers
        default: break
        }
        resignPickerView()
    }
    @IBAction func timeTextFieldAction(_ sender: UITextField) {
        timeTextField.resignFirstResponder()
        UIPickerView.transition(with: pickerView, duration: 0.4, options: [], animations: {
            self.pickerView.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: -self.pickerView.frame.size.height)
            self.timeTextField.text = "00:00:00"
        }, completion: nil)
    }
    @IBAction func submitButton(_ sender: UIButton) {
        if timeTextField.text != "", distanceTextfield.text != "" {
            saveWorkout.addInterval(distance: distanceTextfield.text!, hour: time.hour, minute: time.minute, second: time.second, distanceUnit: distance)
            numberOfRows += 1
            tableView.reloadData()
            let row  = IndexPath(row: numberOfRows - 1, section: 0)
            tableView.scrollToRow(at: row, at: .bottom, animated: true)
            resignPickerView()
        }
    }
    @objc func submitWorkout() {
        saveWorkout.submitWorkout(distance: nil, hour: nil, minute: nil, second: nil, distanceUnit: nil, ViewController: "RecordIntervalWorkoutController()")
        performSegue(withIdentifier: "Record Interval Workout to Table View Controller", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit Workout", style: .done, target: nil, action: #selector(submitWorkout))
        distanceUnitSegmentedController.selectedSegmentIndex = defaultDistanceUnit.index
        let pickerViewRect = CGRect(x: 0, y: view.frame.size.height, width: view.frame.size.width, height: 216)
        pickerView = UIPickerView(frame: pickerViewRect)
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(pickerView)
        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class recordTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lapLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
}
