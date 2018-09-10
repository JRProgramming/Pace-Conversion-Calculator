//
//  recordWorkoutModel.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/25/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import Foundation
import UIKit
struct recordWorkout {
    var distanceArray = [String]()
    var timeArray = [String]()
    var distanceUnitArray = [String]()
    
    
    mutating func addInterval(distance: String, hour: Int, minute: Int, second: Int, distanceUnit: distanceUnit) {
        distanceArray.append(distance)
        let cleanedUpTime = cleanUpTime().cleanUpTime(hour: hour, minute: minute, second: second)
        timeArray.append(cleanedUpTime)
        distanceUnitArray.append(distanceUnit.rawValue)
    }
    
    mutating func removeInterval(at index: Int) {
        distanceArray.remove(at: index)
        timeArray.remove(at: index)
        distanceUnitArray.remove(at: index)
    }
    
    mutating func submitWorkout(distance: String?, hour: Int?, minute: Int?, second: Int?, distanceUnit: distanceUnit?, ViewController: String) {
        let findDate = dateAndTime()
        if ViewController == "RecordSingleRunWorkoutController()" {
            var distanceArray = UserDefaults.standard.object(forKey: "SingleDistance") as? [String] ?? [String]()
            var timeArray = UserDefaults.standard.object(forKey: "SingleTime") as? [String] ?? [String]()
            var distanceUnitArray = UserDefaults.standard.object(forKey: "SingleDistanceUnit") as? [String] ?? [String]()
            var dateArray = UserDefaults.standard.object(forKey: "SingleDate") as? [[String]] ?? [[String]]()
            distanceArray.append(distance!)
            let cleanedUpTime = cleanUpTime().cleanUpTime(hour: hour!, minute: minute!, second: second!)
            timeArray.append(cleanedUpTime)
            distanceUnitArray.append(distanceUnit!.rawValue)
            dateArray.append([findDate.stringDate, findDate.stringTime])
            UserDefaults.standard.set(distanceArray, forKey: "SingleDistance")
            UserDefaults.standard.set(timeArray, forKey: "SingleTime")
            UserDefaults.standard.set(distanceUnitArray, forKey: "SingleDistanceUnit")
            UserDefaults.standard.set(dateArray, forKey: "SingleDate")
        } else if ViewController == "RecordIntervalWorkoutController()" {
            var storedDistanceArray = UserDefaults.standard.object(forKey: "IntervalDistance") as? [[String]] ?? [[String]]()
            var storedTimeArray = UserDefaults.standard.object(forKey: "IntervalTime") as? [[String]] ?? [[String]]()
            var storedDistanceUnitArray = UserDefaults.standard.object(forKey: "IntervalDistanceUnit") as? [[String]] ?? [[String]]()
            var storedDateArray = UserDefaults.standard.object(forKey: "IntervalDate") as? [[String]] ?? [[String]]()
            storedDistanceArray.append(distanceArray)
            storedTimeArray.append(timeArray)
            storedDistanceUnitArray.append(distanceUnitArray)
            storedDateArray.append([findDate.stringDate, findDate.stringTime])
            UserDefaults.standard.set(storedDistanceArray, forKey: "IntervalDistance")
            UserDefaults.standard.set(storedTimeArray, forKey: "IntervalTime")
            UserDefaults.standard.set(storedDistanceUnitArray, forKey: "IntervalDistanceUnit")
            UserDefaults.standard.set(storedDateArray, forKey: "IntervalDate")
        }
    }
}
