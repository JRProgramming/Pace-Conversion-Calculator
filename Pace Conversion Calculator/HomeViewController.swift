//
//  HomeViewController.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/26/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBAction func recordWorkoutAction(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Record a run", style: .default, handler: { Void in
            self.performSegue(withIdentifier: "Home to Record Single Run Workout", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "Record Interval Workout", style: .default, handler: { Void in
            self.performSegue(withIdentifier: "Home to Record Interval Workout", sender: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    @IBAction func mapARun(_ sender: UIButton) {
        var recordingOption = recordingOptions.automatic
        let alert = UIAlertController(
            title: "Choose a recording option",
            message: nil,
            preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Automatic", style: .default, handler: { Void in
            recordingOption = recordingOptions.automatic
            self.performSegue(withIdentifier: "Home to Map", sender: recordingOption)
        }))
        alert.addAction(UIAlertAction(title: "Manual", style: .default, handler: { Void in
            recordingOption = recordingOptions.manual
            self.performSegue(withIdentifier: "Home to Map", sender: recordingOption)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func viewSavedWorkoutAction(_ sender: UIButton) {
        if UserDefaults.standard.object(forKey: "SingleDate") as? [[String]] != [] ||  UserDefaults.standard.object(forKey: "IntervalDate") as? [[String]] != [] {
            performSegue(withIdentifier: "Home to Saved Workout Table View Controller", sender: nil)
        } else {
            let alert = UIAlertController(title: "There are no saved workouts", message: "Please add a workout to view your saved workouts", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Home to Map", let vc = segue.destination as? MapViewController, let recordingOption = sender as? recordingOptions  {
            vc.recordingOption = recordingOption
        }
    }

}

