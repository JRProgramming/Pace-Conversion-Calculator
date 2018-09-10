//
//  cleanUpTime.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/25/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import Foundation

class cleanUpTime {
    func cleanUpSecondsTime(time: Double) -> String {
        let hour = Int(time / 3600)
        let minute = Int((time-(Double(hour*3600)))/60)
        let second = Int(time-((Double(hour*3600))+(Double(minute*60))))
        let stringHour = String(format: "%02d", hour)
        let stringMinute = String(format: "%02d", minute)
        let stringSecond = String(format: "%02d", second)
        return "\(stringHour):\(stringMinute):\(stringSecond)"
    }
    
    func cleanUpTime(hour: Int, minute: Int, second: Int) -> String {
        let stringHour = String(format: "%02d", hour)
        let stringMinute = String(format: "%02d", minute)
        let stringSecond = String(format: "%02d", second)
        return "\(stringHour):\(stringMinute):\(stringSecond)"
    }
}
