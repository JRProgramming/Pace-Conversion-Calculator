//
//  SingleRunViewController.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/26/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import UIKit

class SingleRunViewController: UIViewController {
    var distanceArray = UserDefaults.standard.object(forKey: "SingleDistance") as? [String] ?? [String]()
    var dateArray = UserDefaults.standard.object(forKey: "SingleDate") as? [[String]] ?? [[String]]()
    var distanceUnitArray = UserDefaults.standard.object(forKey: "SingleDistanceUnit") as? [String] ?? [String]()
    var timeArray = UserDefaults.standard.object(forKey: "SingleTime") as? [String] ?? [String]()
    var model = SingleRunModel()
    var index = Int()
    var distance = String()
    var unit = String()
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var mileLabel: UILabel!
    @IBOutlet weak var kilometerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let time = timeArray[index]
        let distance = distanceArray[index]
        let unit = distanceUnitArray[index]
        timeLabel.text = time
        distanceLabel.text = "\(distance) \(unit)"
        mileLabel.text = model.pace(time: time, Distance: Double(distance)!, DistanceUnit: unit).0
        kilometerLabel.text = model.pace(time: time, Distance: Double(distance)!, DistanceUnit: unit).1
        // Do any additional setup after loading the view.
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
