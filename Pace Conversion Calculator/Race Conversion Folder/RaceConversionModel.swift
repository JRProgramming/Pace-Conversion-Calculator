//
//  RaceConversionModel.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/24/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import Foundation

class RaceConversion {
    func convertDistance(hour: Int, minute: Int, second: Int, originalDistance: (Double, distanceUnit), convertedDistance: (Double, distanceUnit)) -> String {
        var mileOriginalDistance = originalDistance.0
        var mileConvertedDistance = convertedDistance.0
        if originalDistance.1 == distanceUnit.kilometers  {
            mileOriginalDistance = originalDistance.0 / 1.60934
        }
        if convertedDistance.1 == distanceUnit.kilometers {
            mileConvertedDistance = convertedDistance.0 / 1.60934
        }
        let distance = pow((mileConvertedDistance/mileOriginalDistance),1.06)
        let newHour = hour.toSeconds(isHour: true)
        let newMinute = minute.toSeconds(isHour: false)
        let convertedTime = newHour + newMinute + second
        let time = Double(convertedTime)*distance
        return cleanUpTime().cleanUpSecondsTime(time: time)
        //t2 = t1 * (d2 / d1)1.06
        //Equation taken from https://www.hillrunner.com/calculators/race-conversion/
    }
}
