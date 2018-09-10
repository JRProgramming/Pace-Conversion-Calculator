//
//  IntervalModel.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/26/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import Foundation

class intervalViewModel {
    
    var totalDistance = Double()
    var totalTime = Double()
    func findTotalAndAverageTime(time: [String], calculatingTotalTime: Bool) -> String {
        var timeSecondArray = [Double]()
        for int in time.indices {
            let hour = time[int].prefix(2)
            let index = time[int].index(time[int].startIndex, offsetBy: 3)
            let endIndex = time[int].index(time[int].endIndex, offsetBy: -3)
            let minute = time[int][index ..< endIndex]
            let second = time[int].suffix(2)
            let secondsTime = Double(convertTimeFormatIntoSeconds(hour: Int(hour)!, minute: Int(minute)!, second: Int(second)!))
            timeSecondArray.append(secondsTime)
        }
        totalTime = timeSecondArray.reduce(0, +)
        if calculatingTotalTime {
            return convertSecondsIntoTimeFormat(seconds: Int(totalTime))
        } else {
            let averageTime = Int(totalTime)/time.count
            return convertSecondsIntoTimeFormat(seconds: averageTime)
        }
    }
    
    func calculateTotalDistance(distance: [String], distanceUnit unit: [String]) -> Double {
        var distanceMileArray = [Double]()
        for int in unit.indices {
            if unit[int] == "kilometers" {
                let convertedToMile = Double(distance[int])!/1.60934
                distanceMileArray.append(convertedToMile)
            } else {
                distanceMileArray.append(Double(distance[int])!)
            }
        }
        totalDistance = distanceMileArray.reduce(0, +)
        return totalDistance
    }
    
    func findPace(distanceUnit: distanceUnit) -> String {
        var pace = Double()
        
        if distanceUnit == .miles {
            pace = totalTime/totalDistance
            
        } else {
            let kilometer = totalDistance*1.60934
            pace = totalTime/kilometer
        }
        return convertSecondsIntoTimeFormat(seconds: Int(pace))
    }
    
    func convertSecondsIntoTimeFormat(seconds: Int) -> String {
        let hour = Int(seconds / 3600)
        let minute = Int((seconds-(hour*3600))/60)
        let second = Int((seconds-((hour*3600)+(minute*60))))
        let stringHour = String(format: "%02d", hour)
        let stringMinute = String(format: "%02d", minute)
        let stringSecond = String(format: "%02d", second)
        return "\(stringHour):\(stringMinute):\(stringSecond)"
    }

    func convertTimeFormatIntoSeconds(hour: Int, minute: Int, second: Int) -> Double {
        return Double((hour * 3600) + (minute * 60) + second)
    }
}
