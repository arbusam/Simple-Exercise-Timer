//
//  ViewController.swift
//  Exercise Timer
//
//  Created by Arhan Busam on 14/7/18.
//  Copyright © 2018 Arhan Busam. All rights reserved.
//

import UIKit

class StartTimerViewController: UIViewController {
    
    var text = "Succces"
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityLabel.text = defaults.string(forKey: "activity")
        restLabel.text = defaults.string(forKey: "rest")
        repLabel.text = defaults.string(forKey: "reps")
        setLabel.text = defaults.string(forKey: "sets")
        
    }
    
    @IBOutlet weak var activityLabel: UITextField!
    @IBOutlet weak var restLabel: UITextField!
    @IBOutlet weak var repLabel: UITextField!
    @IBOutlet weak var setLabel: UITextField!
    
    @IBAction func startButtonPressed() {
        text = "Succces"
        let alert = UIAlertController(title: "Alert", message: "Your values have to cointain a number.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        if let number = Int(activityLabel.text!) {
            print("Working")
        } else {
            text = "Failed"
            self.present(alert, animated: true, completion: nil)
            
        }
        if text != "Failed" {
            if let number = Int(restLabel.text!) {
                print("Working")
            } else {
                text = "Failed"
                self.present(alert, animated: true, completion: nil)
            }
            if text != "Failed" {
                if let number = Int(repLabel.text!) {
                    print("Working")
                } else {
                    text = "Failed"
                    self.present(alert, animated: true, completion: nil)
                }
                if text != "Failed" {
                    if let number = Int(setLabel.text!) {
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
            
            workoutVC.activity = activityLabel.text!
            workoutVC.rest = restLabel.text!
            workoutVC.reps = repLabel.text!
            workoutVC.sets = setLabel.text!
            
            self.defaults.set(workoutVC.activity, forKey: "activity")
            self.defaults.set(workoutVC.rest, forKey: "rest")
            self.defaults.set(workoutVC.reps, forKey: "reps")
            self.defaults.set(workoutVC.sets, forKey: "sets")
            
        }
    }
    
    //TODO: Make sure you can't enter letters.
    

}

