//
//  SecondsConversionModel.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/24/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import Foundation

class secondsConversion {
    func convertSecondsIntoTimeFormat(seconds: Int) -> String {
            let hour = Int(seconds / 3600)
            let minute = Int((seconds-(hour*3600))/60)
            let second = Int((seconds-((hour*3600)+(minute*60))))
            let stringHour = String(format: "%02d", hour)
            let stringMinute = String(format: "%02d", minute)
            let stringSecond = String(format: "%02d", second)
            return "\(stringHour):\(stringMinute):\(stringSecond)"
    }
    
    func convertTimeFormatIntoSeconds(hour: Int, minute: Int, second: Int) -> String {
        return String((hour * 3600) + (minute * 60) + second)
    }
}
