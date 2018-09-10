//
//  IntervalViewController.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/26/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import UIKit

class IntervalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model = intervalViewModel()
    var index = Int()
    var storedDistanceArray = UserDefaults.standard.object(forKey: "IntervalDistance") as? [[String]] ?? [[String]]()
    var storedTimeArray = UserDefaults.standard.object(forKey: "IntervalTime") as? [[String]] ?? [[String]]()
    var storedDistanceUnitArray = UserDefaults.standard.object(forKey: "IntervalDistanceUnit") as? [[String]] ?? [[String]]()
    var storedDateArray = UserDefaults.standard.object(forKey: "IntervalDate") as? [[String]] ?? [[String]]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var averageTimeLabel: UILabel!
    @IBOutlet weak var totalDistanceLabel: UILabel!
    @IBOutlet weak var pacePerMileLabel: UILabel!
    @IBOutlet weak var pacePerKilometerLabel: UILabel!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedDistanceArray[index].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as! intervalTableViewCell
        cell.intervalLabel.text = "Interval #\(indexPath.row + 1)"
        cell.distanceLabel.text = "\(storedDistanceArray[index][indexPath.row]) \(storedDistanceUnitArray[index][indexPath.row])"
        cell.timeLabel.text = storedTimeArray[index][indexPath.row]
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        totalTimeLabel.text = model.findTotalAndAverageTime(time: storedTimeArray[index], calculatingTotalTime: true)
        averageTimeLabel.text = model.findTotalAndAverageTime(time: storedTimeArray[index], calculatingTotalTime: false)
        totalDistanceLabel.text = String(format: "%g", model.calculateTotalDistance(distance: storedDistanceArray[index], distanceUnit: storedDistanceUnitArray[index]))
        pacePerMileLabel.text = model.findPace(distanceUnit: .miles)
        pacePerKilometerLabel.text = model.findPace(distanceUnit: .kilometers)
        tableView.delegate = self
        tableView.dataSource = self
        
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

class intervalTableViewCell: UITableViewCell {
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
}

