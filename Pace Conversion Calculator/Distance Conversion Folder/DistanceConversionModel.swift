//
//  DistanceConversion.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/24/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import Foundation

class distanceConversion {
    func convertDistance(hour: Int, minute: Int, second: Int, originalDistance: (Double, distanceUnit), convertedDistance: (Double, distanceUnit)) -> String {
        var mileOriginalDistance = originalDistance.0
        var mileConvertedDistance = convertedDistance.0
        if originalDistance.1 == distanceUnit.kilometers  {
            mileOriginalDistance = originalDistance.0 / 1.60934
        }
        if convertedDistance.1 == distanceUnit.kilometers {
            mileConvertedDistance = convertedDistance.0 / 1.60934
        }
        let distance = mileOriginalDistance / mileConvertedDistance
        let newHour = hour.toSeconds(isHour: true)
        let newMinute = minute.toSeconds(isHour: false)
        let convertedTime = newHour + newMinute + second
        let convertTimeToDistance = Double(convertedTime) / distance
        return cleanUpTime().cleanUpSecondsTime(time: convertTimeToDistance)
    }
}

extension Int {
    func toSeconds(isHour: Bool) -> Int {
        if isHour {
            return self * 3600
        } else {
            return self * 60
        }
    }
}
