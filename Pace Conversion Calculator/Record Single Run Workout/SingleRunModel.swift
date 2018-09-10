//
//  SingleRunModel.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/26/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import Foundation

class SingleRunModel {
    func pace(time: String, Distance: Double, DistanceUnit: String) -> (String, String){
        let hour = time.prefix(2)
        let index = time.index(time.startIndex, offsetBy: 3)
        let endIndex = time.index(time.endIndex, offsetBy: -3)
        let minute = time[index ..< endIndex]
        let second = time.suffix(2)
        let secondsTime = Double(convertTimeFormatIntoSeconds(hour: Int(hour)!, minute: Int(minute)!, second: Int(second)!))
        if DistanceUnit == "miles" {
            let milePace = secondsTime/Distance
            let kilometer = Distance * 1.60934
            let kilometerPace = secondsTime/kilometer
            return (convertSecondsIntoTimeFormat(seconds: Double(milePace)), convertSecondsIntoTimeFormat(seconds: Double(kilometerPace)))
        } else {
            let mile = Distance / 1.60934
            let milePace = secondsTime/mile
            let kilometerPace = secondsTime/Distance
            return (convertSecondsIntoTimeFormat(seconds: Double(milePace)), convertSecondsIntoTimeFormat(seconds: Double(kilometerPace)))
        }
    }
    func convertSecondsIntoTimeFormat(seconds: Double) -> String {
        let hour = Int(seconds / 3600)
        let minute = Int((seconds-Double((hour*3600)))/60)
        let second = Int(seconds-Double(((hour*3600)+(minute*60))))
        let stringHour = String(format: "%02d", hour)
        let stringMinute = String(format: "%02d", minute)
        let stringSecond = String(format: "%02d", second)
        return "\(stringHour):\(stringMinute):\(stringSecond)"
    }
    
    func convertTimeFormatIntoSeconds(hour: Int, minute: Int, second: Int) -> Double {
        return Double((hour * 3600) + (minute * 60) + second)
    }
}
