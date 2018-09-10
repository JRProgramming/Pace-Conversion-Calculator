//
//  SavedMapViewController.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 9/8/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class SavedMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var distance: String?
    var areaCoordinate = [Int : [CLLocationCoordinate2D]]()
    var areaArray = [Int : [CLLocation]]()
    var index = Int()
    var indexArray = [Int]()
    var DateAndTime = dateAndTime()
    var longitudeLatitudeArray = [String: [[String]]]()
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func button(_ sender: UIButton) {
        saveMap()
    }
    func saveMap() {
        var areaTripleArray = UserDefaults.standard.object(forKey: "areaArray") as? [[[CLLocation]]] ?? [[[CLLocation]]]()
        var mapDistance = UserDefaults.standard.object(forKey: "mapDistance") as? [String] ?? [String]()
        var mapDate = UserDefaults.standard.object(forKey: "mapDate") as? [[String]] ?? [[String]]()
        var areaDoubleArray = [[CLLocation]]()
        for index in 0..<areaArray.count {
            areaDoubleArray.append(areaArray[index] ?? [])
        }
        areaTripleArray.append(areaDoubleArray)
        mapDistance.append(distance!)
        let date = DateAndTime.stringDate
        let time = DateAndTime.stringTime
        mapDate.append([date, time])
        UserDefaults.standard.set(areaTripleArray, forKey: "areaArray")
        UserDefaults.standard.set(distance, forKey: "mapDistanceArray")
        UserDefaults.standard.set(mapDate, forKey: "mapDateArray")
        performSegue(withIdentifier: "Saved Map to Saved Workouts", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.mapType = MKMapType(rawValue: 0)!
        if distance != nil {
            distanceLabel.text = distance
            var locationCoordinates = [CLLocationCoordinate2D]()
            for index in longitudeLatitudeArray.keys {
                for subIndex in longitudeLatitudeArray[index]!.indices {
                    if let array = longitudeLatitudeArray[index] {
                        let latitude = CLLocationDegrees(array[subIndex][0])
                        let longitude = CLLocationDegrees(array[subIndex][1])
                        locationCoordinates.append(CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!))
                    }
                }
                let polyline = MKPolyline(coordinates: locationCoordinates, count: locationCoordinates.count)
                mapView.addOverlay(polyline)
                locationCoordinates.removeAll()
            }
            var coordinates = [CLLocationCoordinate2D]()
            for index in areaCoordinate.keys {
                coordinates += (areaCoordinate[index]!)
            }
            let region = MKCoordinateRegion(coordinates: coordinates)
            mapView.setRegion(region, animated: true)
        } else {
            var areaTripleArray = UserDefaults.standard.object(forKey: "areaArray") as? [[[CLLocation]]] ?? [[[CLLocation]]]()
            var mapDistance = UserDefaults.standard.object(forKey: "mapDistance") as? [String] ?? [String]()
            distanceLabel.text = mapDistance[index]
            var coordinatesArray = [CLLocationCoordinate2D]()
            for headIndex in areaTripleArray[index].indices {
                for subIndex in areaTripleArray[index][headIndex].indices {
                    coordinatesArray.append(areaTripleArray[index][headIndex][subIndex].coordinate)
                }
                let polyline = MKPolyline(coordinates: coordinatesArray, count: coordinatesArray.count)
                mapView.addOverlay(polyline)
                coordinatesArray = []
            }
            var coordinates = [CLLocationCoordinate2D]()
            for headIndex in areaTripleArray[index].indices {
                for subIndex in areaTripleArray[headIndex].indices {
                    coordinates.append((areaArray[headIndex]?[subIndex].coordinate)!)
                }
            }
            let region = MKCoordinateRegion(coordinates: coordinates)
            mapView.setRegion(region, animated: true)
        }
        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let pr = MKPolylineRenderer(overlay: overlay)
        pr.strokeColor = UIColor.blue
        pr.lineWidth = 5
        return pr
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UserDefaults {
    
    func set(location:[[[CLLocation]]], forKey key: String){
        var latitudeArray = [[[Int]]]()
        var longitudeArray = [[[Int]]]()
        var firstLatArray = [Int]()
        var secondLatArray = [[Int]]()
        var firstLongArray = [Int]()
        var secondLongArray = [[Int]]()
        for firstIndex in location.indices {
            for secondIndex in location[firstIndex].indices {
                for thirdIndex in location[firstIndex][secondIndex].indices {
                    let locationLat = NSNumber(value:location[firstIndex][secondIndex][thirdIndex].coordinate.latitude)
                    firstLatArray.append(Int(truncating: locationLat))
                    let locationLon = NSNumber(value:location[firstIndex][secondIndex][thirdIndex].coordinate.longitude)
                    firstLongArray.append(Int(truncating: locationLon))
                }
                secondLatArray.append(firstLatArray)
                secondLongArray.append(firstLongArray)
            }
            latitudeArray.append(secondLatArray)
            longitudeArray.append(secondLongArray)
        }
        self.set(["lat": latitudeArray, "lon": longitudeArray], forKey:key)
    }
    
    func location(forKey key: String) -> CLLocation?
    {
        if let locationDictionary = self.object(forKey: key) as? Dictionary<String,NSNumber> {
            let locationLat = locationDictionary["lat"]!.doubleValue
            let locationLon = locationDictionary["lon"]!.doubleValue
            return CLLocation(latitude: locationLat, longitude: locationLon)
        }
        return nil
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
