//
//  ViewController.swift
//  Simple Exersice Timer
//
//  Created by Arhan Busam on 14/7/18.
//  Copyright © 2018 Arhan Busam. All rights reserved.
//

import UIKit

class StartTimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var activityData:[String] = [String]()
    
    var text = "Succces"
    
    let defaults = UserDefaults.standard
    
    var activityValue = 0
    var restValue = 0
    var repsValue = 0
    var setsValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.restLabel.delegate = self
        self.restLabel.dataSource = self
        
        for i in 0...60 {
            print(i)
            activityData.append("\(i)")
        }
        print(activityData)
        restLabel.selectRow(defaults.integer(forKey: "dropdownActivity"), inComponent: 0, animated: true)
        restLabel.selectRow(defaults.integer(forKey: "dropdownRest"), inComponent: 1, animated: true)
        restLabel.selectRow(defaults.integer(forKey: "dropdownReps"), inComponent: 2, animated: true)
        restLabel.selectRow(defaults.integer(forKey: "dropdownSets"), inComponent: 3, animated: true)
        
        activityValue = defaults.integer(forKey: "dropdownActivity")
        restValue = defaults.integer(forKey: "dropdownRest")
        repsValue = defaults.integer(forKey: "dropdownReps")
        setsValue = defaults.integer(forKey: "dropdownSets")
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 4
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return activityData.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return activityData[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print(component)
        if component == 0 {
            self.defaults.set(row, forKey: "dropdownActivity")
            activityValue = row
        }
        
        if component == 1 {
            self.defaults.set(row, forKey: "dropdownRest")
            restValue = row
        }
        
        if component == 2 {
            self.defaults.set(row, forKey: "dropdownReps")
            repsValue = row
        }
        
        if component == 3 {
            self.defaults.set(row, forKey: "dropdownSets")
            setsValue = row
        }
        
    }
    
    
    @IBOutlet weak var restLabel: UIPickerView!
    
    
    @IBAction func startButtonPressed() {
        
        text = "Succces"
        let alert = UIAlertController(title: "Alert", message: "Your values have to cointain something.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))

        if activityValue != 0 {
            print("Working")
        } else {
            text = "Failed"
            self.present(alert, animated: true, completion: nil)

        }
        if text != "Failed" {
            if restValue != 0 {
                print("Working")
            } else {
                text = "Failed"
                self.present(alert, animated: true, completion: nil)
            }
            if text != "Failed" {
                if repsValue != 0 {
                    print("Working")
                } else {
                    text = "Failed"
                    self.present(alert, animated: true, completion: nil)
                }
                if text != "Failed" {
                    if setsValue != 0 {
                        print("Working")
                    } else {
                        text = "Failed"
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        if text == "Succces" {
            performSegue(withIdentifier: "startSegue", sender: self)
        } else {
            print(text)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startSegue" {

            let workoutVC = segue.destination as! WorkoutViewController

            workoutVC.activity = String(activityValue)
            workoutVC.rest = String(restValue)
            workoutVC.reps = String(repsValue)
            workoutVC.sets = String(setsValue)

            self.defaults.set(workoutVC.activity, forKey: "activity")
            self.defaults.set(workoutVC.rest, forKey: "rest")
            self.defaults.set(workoutVC.reps, forKey: "reps")
            self.defaults.set(workoutVC.sets, forKey: "sets")

        }
    }
    
    //TODO: Make sure you can't enter letters.
    
    
}

