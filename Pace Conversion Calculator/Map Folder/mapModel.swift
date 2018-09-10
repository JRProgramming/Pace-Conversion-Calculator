//
//  mapModel.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 9/4/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class mapModel {
    var automaticModel = automatic()
    var manualModel = manual()
    class automatic {
        var areaCoordinate = [Int : [CLLocationCoordinate2D]]()
        var areaArray = [Int : [CLLocation]]()
        var drawMap = false
        var index = Int()
        var isRecording = true {
            didSet {
                index += 1
            }
        }
        var oldLocation: CLLocation?
        func updateLocation(manager: CLLocationManager, locations: [CLLocation]) {
            drawMap = false
            if let location = manager.location {
                if isRecording {
                    if let _ = areaCoordinate[index], let _ = areaArray[index], location.speed >= 1 && location.speed < 10, let oldLocation = oldLocation, location.distance(from: oldLocation) <= 10 {
                        areaCoordinate[index]!.append(manager.location!.coordinate)
                        areaArray[index]!.append(location)
                        drawMap = true
                    } else if let oldLocation = oldLocation, areaCoordinate[index] == nil || areaArray[index] == nil, location.speed >= 1, location.speed < 10, location.distance(from: oldLocation) <= 10 {
                        areaCoordinate[index] = [location.coordinate]
                        areaArray[index] = [location]
                        drawMap = true
                    } else if let oldLocation = oldLocation, location.speed < 1 || location.speed > 10 || location.distance(from: oldLocation) >= 10 {
                        isRecording = false
                    }
                } else {
                    if let _ = areaCoordinate[index], let _ = areaArray[index], let oldLocation = oldLocation, location.speed >= 1, location.speed < 10, location.distance(from: oldLocation) <= 10 {
                        areaCoordinate[index]!.append(manager.location!.coordinate)
                        areaArray[index]!.append(location)
                        isRecording = true
                    } else if areaCoordinate[index] == nil || areaArray[index] == nil, location.speed >= 1, location.speed < 10 {
                        areaCoordinate[index] = [location.coordinate]
                        areaArray[index] = [location]
                        isRecording = true
                    }
                }
                self.oldLocation = manager.location
            }
        }
    }
    class manual {
        
    }
    func findDistance(area areaArray: [Int: [CLLocation]], index: Int) -> String {
        var totalDistance = CLLocationDistance()
        for i in 0...index {
            if let areaArray = areaArray[i] {
                for int in 0..<areaArray.count-1 {
                    let distance = areaArray[int + 1].distance(from: areaArray[int])
                    totalDistance = totalDistance + distance
                }
            }
        }
        if defaultDistanceUnit == .miles {
            return String(format: "%.02f", (totalDistance * 0.00062137))
        } else {
            return String(format: "%.02f", (totalDistance * 0.001))
        }
    }
}
enum recordingOptions {
    case automatic
    case manual
}
