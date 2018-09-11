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
    var DateAndTime = dateAndTime()
    var model = ViewMap()
    var longitudeLatitudeArray = [String: [[String]]]()
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @objc func saveMap() {
        model.saveMap(distance: distance, longitudeAndLatitude: longitudeLatitudeArray)
        performSegue(withIdentifier: "Saved Map to Saved Workouts", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.mapType = MKMapType(rawValue: 0)!
        if distance != nil {
            distanceLabel.text = distance
            var locationCoordinates = [CLLocationCoordinate2D]()
            var regionCoordinates = [CLLocationCoordinate2D]()
            for index in longitudeLatitudeArray.keys {
                for subIndex in longitudeLatitudeArray[index]!.indices {
                    if let array = longitudeLatitudeArray[index] {
                        let latitude = CLLocationDegrees(array[subIndex][0])
                        let longitude = CLLocationDegrees(array[subIndex][1])
                        locationCoordinates.append(CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!))
                        regionCoordinates.append(CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!))
                    }
                }
                let polyline = MKPolyline(coordinates: locationCoordinates, count: locationCoordinates.count)
                mapView.addOverlay(polyline)
                locationCoordinates.removeAll()
            }
            let region = MKCoordinateRegion(coordinates: regionCoordinates)
            mapView.setRegion(region, animated: true)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveMap))
        } else {
            var areaArray = UserDefaults.standard.object(forKey: "areaArray") as? [[String: [[String]]]] ?? [[String: [[String]]]]()
            var mapDistance = UserDefaults.standard.object(forKey: "mapDistance") as? [String] ?? [String]()
            distanceLabel.text = mapDistance[index]
            var locationCoordinates = [CLLocationCoordinate2D]()
            var regionCoordinates = [CLLocationCoordinate2D]()
            for headIndex in areaArray[index].keys {
                for subIndex in areaArray[index][headIndex]!.indices {
                    if let array = areaArray[index][headIndex] {
                        let latitude = CLLocationDegrees(array[subIndex][0])
                        let longitude = CLLocationDegrees(array[subIndex][1])
                        locationCoordinates.append(CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!))
                        regionCoordinates.append(CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!))
                    }
                }
                let polyline = MKPolyline(coordinates: locationCoordinates, count: locationCoordinates.count)
                mapView.addOverlay(polyline)
                locationCoordinates.removeAll()
            }
            let region = MKCoordinateRegion(coordinates: regionCoordinates)
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
