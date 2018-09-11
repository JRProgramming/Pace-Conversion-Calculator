//
//  SavedMapModel.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 9/8/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class ViewMap {
    var DateAndTime = dateAndTime()
    func saveMap(distance: String!, longitudeAndLatitude array: [String: [[String]]]) {
        var areaArray = UserDefaults.standard.object(forKey: "areaArray") as? [[String: [[String]]]] ?? [[String: [[String]]]]()
        var mapDistance = UserDefaults.standard.object(forKey: "mapDistance") as? [String] ?? [String]()
        var mapDate = UserDefaults.standard.object(forKey: "mapDate") as? [[String]] ?? [[String]]()
        mapDistance.append(distance!)
        let date = DateAndTime.stringDate
        let time = DateAndTime.stringTime
        mapDate.append([date, time])
        areaArray.append(array)
        UserDefaults.standard.set(areaArray, forKey: "areaArray")
        UserDefaults.standard.set(mapDistance, forKey: "mapDistance")
        UserDefaults.standard.set(mapDate, forKey: "mapDate")
    }
}

extension MKCoordinateRegion {
    
    init(coordinates: [CLLocationCoordinate2D]) {
        var minLatitude: CLLocationDegrees = 90.0
        var maxLatitude: CLLocationDegrees = -90.0
        var minLongitude: CLLocationDegrees = 180.0
        var maxLongitude: CLLocationDegrees = -180.0
        
        for coordinate in coordinates {
            let lat = Double(coordinate.latitude)
            let long = Double(coordinate.longitude)
            if lat < minLatitude {
                minLatitude = lat
            }
            if long < minLongitude {
                minLongitude = long
            }
            if lat > maxLatitude {
                maxLatitude = lat
            }
            if long > maxLongitude {
                maxLongitude = long
            }
        }
        maxLatitude += 0.0005
        minLatitude -= 0.0005
        maxLongitude += 0.0005
        minLongitude -= 0.0005
        
        let span = MKCoordinateSpan(latitudeDelta: ((maxLatitude - minLatitude)), longitudeDelta: ((maxLongitude - minLongitude)))
        let center = CLLocationCoordinate2DMake((maxLatitude - span.latitudeDelta / 2), (maxLongitude - span.longitudeDelta / 2))
        self.init(center: center, span: span)
    }
}
