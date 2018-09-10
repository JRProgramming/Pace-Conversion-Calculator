//
//  MapViewController.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 9/1/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var totalDistanceLabel: UILabel!
    var automaticModel = mapModel().automaticModel
    var manualModel = mapModel().manualModel
    var recordingOption = recordingOptions.automatic
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if recordingOption == .automatic {
            automaticModel.updateLocation(manager: manager, locations: locations)
            if automaticModel.drawMap {
                drawMap()
            }
        }
    }
    
    func drawMap() {
        if recordingOption == .automatic {
            let polyline = MKPolyline(coordinates: automaticModel.areaCoordinate[automaticModel.index]!, count: automaticModel.areaCoordinate[automaticModel.index]!.count)
            mapView.addOverlay(polyline)
            totalDistanceLabel.text = "\(mapModel().findDistance(area: automaticModel.areaArray, index: automaticModel.index)) \(defaultDistanceUnit)"
            mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
        }
    }
    
    @IBOutlet weak var recordingButton: UIButton!
    @IBAction func recordingButton(_ sender: UIButton) {
        if recordingOption == .automatic {
            if recordingButton.titleLabel?.text == "Stop" {
                automaticModel.isRecording = false
                locationManager.stopUpdatingLocation()
                locationManager.stopUpdatingLocation()
                recordingButton.backgroundColor = UIColor.blue
                recordingButton.setTitle("Save", for: .normal)
            } else {
                performSegue(withIdentifier: "Map to Saved Map", sender: nil)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let pr = MKPolylineRenderer(overlay: overlay)
        pr.strokeColor = UIColor.blue
        pr.lineWidth = 5
        return pr
    }
    
    //function to add annotation to map view
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined || status == .denied || status == .authorizedWhenInUse {
            // present an alert indicating location authorization required
            // and offer to take the user to Settings for the app via
            // UIApplication -openUrl: and UIApplicationOpenSettingsURLString
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        if recordingOption == .automatic  {
            automaticModel.isRecording = false
            recordingButton.backgroundColor = UIColor.red
            recordingButton.setTitle("Stop", for: .normal)
        }
        //mapview setup to show user location
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType(rawValue: 0)!
        mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
        // Do any additional setup after loading the view.
    }
    

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Map to Saved Map", let vc = segue.destination as? SavedMapViewController {
            if recordingOption == .automatic {
                vc.areaArray = automaticModel.areaArray
                vc.areaCoordinate = automaticModel.areaCoordinate
                vc.index = automaticModel.index
                vc.distance = totalDistanceLabel.text ?? "0 miles"
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
