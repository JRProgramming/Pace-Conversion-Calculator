//
//  activateTimePickerView.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/29/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import Foundation
import UIKit

protocol timePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    var time: (hour: Int, minute: Int, second: Int) {
        get set
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
}
