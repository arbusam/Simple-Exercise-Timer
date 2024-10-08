//
//  ViewController.swift
//  Simple Exersice Timer
//
//  Created by Arhan Busam on 14/7/18.
//  Copyright © 2018 Arhan Busam. All rights reserved.
//

import UIKit
import MessageUI
import HealthKit

class StartTimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate {
    
    var activityData:[String] = [String]()
    var restData:[String] = [String]()
    var setData:[String] = [String]()
    var repData:[String] = [String]()
    
    var text = "Succces"
    
    let methods = Methods()
    
    let defaults = UserDefaults.standard
    
    var activityValue = 0
    var restValue = 0
    var repsValue = 0
    var setsValue = 0
    
    @IBOutlet weak var brightnesSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.restLabel.delegate = self
        self.restLabel.dataSource = self
        
        brightnesSlider.value = Float(UIScreen.main.brightness)
        
        activityData.append("Action")
        restData.append("Break")
        repData.append("Sets")
        setData.append("Reps")
        
        for i in 1...60 {
            print(i)
            activityData.append("\(i)")
            restData.append("\(i)")
            setData.append("\(i)")
            repData.append("\(i)")
        }
        print(activityData)
        restLabel.selectRow(defaults.integer(forKey: "dropdownActivity"), inComponent: 0, animated: true)
        restLabel.selectRow(defaults.integer(forKey: "dropdownRest"), inComponent: 1, animated: true)
        restLabel.selectRow(defaults.integer(forKey: "dropdownSets"), inComponent: 2, animated: true)
        restLabel.selectRow(defaults.integer(forKey: "dropdownReps"), inComponent: 3, animated: true)
        
        activityValue = defaults.integer(forKey: "dropdownActivity")
        restValue = defaults.integer(forKey: "dropdownRest")
        repsValue = defaults.integer(forKey: "dropdownReps")
        setsValue = defaults.integer(forKey: "dropdownSets")
        
        
        if HKHealthStore.isHealthDataAvailable() {
            // Add code to use HealthKit here.
            
            let healthStore = HKHealthStore()
            
            let allTypes = Set([HKObjectType.workoutType()])
            
            healthStore.requestAuthorization(toShare: allTypes, read: nil) { (success, error) in
                if !success {
                    // Handle the error here.
                    print(error!)
                }
            }
            
        }
        
    }
    
    @IBAction func brighnessChanged(_ sender: UISlider) {
        UIScreen.main.brightness = CGFloat(sender.value)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 4
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return activityData.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return activityData[row]
        } else if component == 1 {
            return restData[row]
        } else if component == 2 {
            return setData[row]
        } else if component == 3 {
            return repData[row]
        } else {
            fatalError("Could not create the row \(component)")
        }
        
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
            self.defaults.set(row, forKey: "dropdownSets")
            setsValue = row
        }
        
        if component == 3 {
            self.defaults.set(row, forKey: "dropdownReps")
            repsValue = row
        }
        
    }
    
    
    @IBOutlet weak var restLabel: UIPickerView!
    
    
    @IBAction func startButtonPressed() {
        text = "Succces"
        let alert = UIAlertController(title: "Alert", message: "All your values have to contain something.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))

        if activityValue != 0 {
            print("Working")
        } else {
            text = "Failed"
            self.present(alert, animated: true, completion: nil)

        }
        
        if methods.validateSettings(activity: activityValue, rest: restValue, sets: setsValue, reps: repsValue) == true {
            performSegue(withIdentifier: "startSegue", sender: self)
        } else {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startSegue" {

            let workoutVC = segue.destination as! WorkoutViewController

            workoutVC.activity = String(activityValue)
            workoutVC.rest = String(restValue)
            workoutVC.reps = String(repsValue)
            workoutVC.sets = String(setsValue)
            
            workoutVC.modalPresentationStyle = .fullScreen

//            self.defaults.set(workoutVC.activity, forKey: "activity")
//            self.defaults.set(workoutVC.rest, forKey: "rest")
//            self.defaults.set(workoutVC.reps, forKey: "reps")
//            self.defaults.set(workoutVC.sets, forKey: "sets")

        }
    }
    
//    @IBAction func helpButtonPressed(_ sender: UIBarButtonItem) {
//        let mailComposeController = configureMailController()
//        if MFMailComposeViewController.canSendMail() {
//            self.present(mailComposeController, animated: true, completion: nil)
//        } else {
//            showMailError()
//        }
//
//    }
    
    //TODO: Feedback
//    func configureMailController() -> MFMailComposeViewController {
//
//        let mailComposerVC = MFMailComposeViewController()
//        mailComposerVC.mailComposeDelegate = self
//
//        mailComposerVC.setToRecipients(["ab.apphelp@gmail.com"])
//        mailComposerVC.setSubject("Help with Simple Exercise Timer")
//        mailComposerVC.setMessageBody("I need help with the app Simple Exercise Timer \n I need help with: \n", isHTML: false)
//
//        return mailComposerVC
//
//    }
    
//    func showMailError() {
//
//        let mailErrorAlert = UIAlertController(title: "Could not send email", message: "There was an error sending the email.", preferredStyle: .alert)
//
//        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
//
//        mailErrorAlert.addAction(dismiss)
//
//        self.present(mailErrorAlert, animated: true, completion: nil)
//
//    }
//
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true, completion: nil)
//    }
    
}

