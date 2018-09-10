//
//  testTableViewController.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/29/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class savedWorkoutsViewcontroller: UITableViewController {

    var storedIntervalDistanceArray = UserDefaults.standard.object(forKey: "IntervalDistance") as? [[String]] ?? [[String]]()
    var storedIntervalTimeArray = UserDefaults.standard.object(forKey: "IntervalTime") as? [[String]] ?? [[String]]()
    var storedIntervalDistanceUnitArray = UserDefaults.standard.object(forKey: "IntervalDistanceUnit") as? [[String]] ?? [[String]]()
    var storedIntervalDateArray = UserDefaults.standard.object(forKey: "IntervalDate") as? [[String]] ?? [[String]]()
    var storedSingleDistanceArray = UserDefaults.standard.object(forKey: "SingleDistance") as? [String] ?? [String]()
    var storedSingleTimeArray = UserDefaults.standard.object(forKey: "SingleTime") as? [String] ?? [String]()
    var storedSingleDistanceUnitArray = UserDefaults.standard.object(forKey: "SingleDistanceUnit") as? [String] ?? [String]()
    var storedSingleDateArray = UserDefaults.standard.object(forKey: "SingleDate") as? [[String]] ?? [[String]]()
    var areaArray = UserDefaults.standard.object(forKey: "areaArray") as? [String: [[String]]] ?? [String: [[String]]]()
    var storedMapDistanceArray = UserDefaults.standard.object(forKey: "mapDistance") as? [String] ?? [String]()
    var storedMapDateArray = UserDefaults.standard.object(forKey: "mapDate") as? [[String]] ?? [[String]]()
    var dateAndTimeArray = [dateAndTime]()
    var timeHour: Int?
    var timeMinute: Int?
    var timeSecond: Int?
    var hour = String()
    var minute = String()
    var second = String()
    var dateDay: Int?
    var dateMonth: Int?
    var dateYear: Int?
    var day = String()
    var month = String()
    var year = String()
    var time = String()
    var date = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        orderWorkouts()
        navigationItem.title = "Saved Workouts"
        if let rootViewController = navigationController?.viewControllers.first {
            navigationController?.viewControllers = [rootViewController, self]
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dateAndTimeArray.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            var index = 0
            while index <= storedSingleDateArray.count - 1 {
                gatherDateAndTime(row: indexPath.row)
                if storedSingleDateArray[index][1] == time && storedSingleDateArray[index][0] == date {
                    storedSingleDistanceArray.remove(at: index)
                    storedSingleDateArray.remove(at: index)
                    storedSingleDistanceUnitArray.remove(at: index)
                    storedSingleTimeArray.remove(at: index)
                    UserDefaults.standard.set(storedSingleDistanceArray, forKey: "SingleDistance")
                    UserDefaults.standard.set(storedSingleDateArray, forKey: "SingleDate")
                    UserDefaults.standard.set(storedSingleDistanceUnitArray, forKey: "SingleDistanceUnit")
                    UserDefaults.standard.set(storedSingleTimeArray, forKey: "SingleTime")
                }
                index += 1
            }
            index = 0
            while index <= storedIntervalDateArray.count - 1 {
                gatherDateAndTime(row: indexPath.row)
                if storedIntervalDateArray[index][1] == time && storedIntervalDateArray[index][0] == date {                    storedIntervalDistanceArray.remove(at: index)
                    storedIntervalDateArray.remove(at: index)
                    storedIntervalDistanceUnitArray.remove(at: index)
                    storedIntervalTimeArray.remove(at: index)
                    UserDefaults.standard.set(storedIntervalDistanceArray, forKey: "IntervalDistance")
                    UserDefaults.standard.set(storedIntervalTimeArray, forKey: "IntervalTime")
                    UserDefaults.standard.set(storedIntervalDistanceUnitArray, forKey: "IntervalDistanceUnit")
                    UserDefaults.standard.set(storedIntervalDateArray, forKey: "IntervalDate")
                }
                index += 1
            }
            index = 0
            while index <= storedMapDateArray.count - 1 {
                gatherDateAndTime(row: indexPath.row)
                if storedMapDateArray[index][1] == time && storedMapDateArray[index][0] == date {
                    storedMapDateArray.remove(at: index)
                    storedMapDistanceArray.remove(at: index)
                    areaArray.removeValue(forKey: "\(index)")
                    UserDefaults.standard.set(areaArray, forKey: "areaArray")
                    UserDefaults.standard.set(storedMapDistanceArray, forKey: "mapDistance")
                    UserDefaults.standard.set(storedMapDateArray, forKey: "mapDate")
                }
                index += 1
            }
            dateAndTimeArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            if dateAndTimeArray.count == 0 {
                navigationController?.popToRootViewController(animated: true)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        // Configure the cell...
        for index in storedSingleDateArray.indices {
            gatherDateAndTime(row: indexPath.row)
            if storedSingleDateArray[index][1] == time && storedSingleDateArray[index][0] == date {
                cell.textLabel?.text = "Run #\(index + 1) (\(date))"
                cell.detailTextLabel?.text = "\(storedSingleDistanceArray[index]) \(storedSingleDistanceUnitArray[index])"

            }
        }
        for index in storedIntervalDateArray.indices {
            gatherDateAndTime(row: indexPath.row)
            if storedIntervalDateArray[index][1] == time && storedIntervalDateArray[index][0] == date {
                cell.textLabel?.text = "Interval Workout #\(index + 1) (\(storedIntervalDateArray[index][0]))"
                cell.detailTextLabel?.text = ""
            }
        }
        for index in storedMapDateArray.indices {
            gatherDateAndTime(row: indexPath.row)
            if storedMapDateArray[index][1] == time && storedMapDateArray[index][0] == date {
                cell.textLabel?.text = "Map Workout #\(index + 1) (\(storedMapDateArray[index][0]))"
                cell.detailTextLabel?.text = "\(storedMapDistanceArray[index])"
            }
        }
        return cell
    }
    
    func orderWorkouts() {
        if let singleDateArray = UserDefaults.standard.object(forKey: "SingleDate") as? [[String]]{
            for index in singleDateArray.indices {
                let date = singleDateArray[index][0].dateStructure
                let time = singleDateArray[index][1].timeStructure
                let dateAndTimeModel = dateAndTime(arrayDate: date, arrayTime: time)
                dateAndTimeArray.append(dateAndTimeModel)
            }
        }
        if let intervalDateArray = UserDefaults.standard.object(forKey: "IntervalDate") as? [[String]] {
            for index in intervalDateArray.indices {
                let date = intervalDateArray[index][0].dateStructure
                let time = intervalDateArray[index][1].timeStructure
                let dateAndTimeModel = dateAndTime(arrayDate: date, arrayTime: time)
                dateAndTimeArray.append(dateAndTimeModel)
            }
        }
        if let mapDateArray = UserDefaults.standard.object(forKey: "mapDate") as? [[String]]  {
            for index in mapDateArray.indices {
                let date = mapDateArray[index][0].dateStructure
                let time = mapDateArray[index][1].timeStructure
                let dateAneTimeModel = dateAndTime(arrayDate: date, arrayTime: time)
                dateAndTimeArray.append(dateAneTimeModel)
            }
        }
        dateAndTimeArray.sort()
    }
    
    func gatherDateAndTime(row index: Int) {
        timeHour = dateAndTimeArray[index].arrayTime?.hour
        timeMinute = dateAndTimeArray[index].arrayTime?.minute
        timeSecond = dateAndTimeArray[index].arrayTime?.second
        hour = String(format: "%02d", timeHour!)
        minute = String(format: "%02d", timeMinute!)
        second = String(format: "%02d", timeSecond!)
        dateDay = dateAndTimeArray[index].arrayDate?.day
        dateMonth = dateAndTimeArray[index].arrayDate?.month
        dateYear = dateAndTimeArray[index].arrayDate?.year
        day = String(format: "%02d", dateDay!)
        month = String(format: "%02d", dateMonth!)
        year = String(format: "%02d", dateYear!)
        time = "\(hour):\(minute):\(second)"
        date = "\(month)/\(day)/\(year)"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for index in storedSingleDateArray.indices {
            gatherDateAndTime(row: indexPath.row)
            if storedSingleDateArray[index][1] == time && storedSingleDateArray[index][0] == date {
                performSegue(withIdentifier: "Saved Workouts To Single Run View Controller", sender: index)
            }
        }
        for index in storedIntervalDateArray.indices {
            gatherDateAndTime(row: indexPath.row)
            if storedIntervalDateArray[index][1] == time && storedIntervalDateArray[index][0] == date {
                performSegue(withIdentifier: "Saved Workouts To Interval View Controller", sender: index)
            }
        }
        for index in storedMapDateArray.indices {
            gatherDateAndTime(row: indexPath.row)
            if storedMapDateArray[index][1] == time && storedMapDateArray[index][0] == date {
                performSegue(withIdentifier: "Saved Workouts to Map", sender: index)
            }
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let ViewController = segue.destination as? IntervalViewController, let index = sender as? Int {
            ViewController.index = index
        } else if let ViewController = segue.destination as? SingleRunViewController, let index = sender as? Int {
            ViewController.index = index
        } else if let ViewController = segue.destination as? SavedMapViewController, let index = sender as? Int {
            ViewController.index = index
        }
    }
}
