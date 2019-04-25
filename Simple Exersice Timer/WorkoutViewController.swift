//
//  WorkoutViewController.swift
//  Exercise Timer
//
//  Created by Arhan Busam on 16/7/18.
//  Copyright © 2018 Arhan Busam. All rights reserved.
//

import UIKit
import AVFoundation
import ChameleonFramework

class WorkoutViewController: UIViewController {
    
    
    
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    
    
    var timer = Timer()
    var seconds = 3
    
    var activity = ""
    var rest = ""
    var reps = ""
    var sets = ""
    
    var numActivity = 0
    var numRest = 0
    var repNum = 0
    var setNum = 0
    
    var pause = false
    var exersicing = true
    
    var player: AVAudioPlayer?
    
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var repLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var homeButton: UIBarButtonItem!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var backButton: UIToolbar!
    
    @objc func clock() {
        seconds -= 1
        countdownLabel.text = String(seconds)
        if seconds == 0 {
            countdownLabel.text = "Go!"
            statusLabel.text = "Activity"
            
        }
        if seconds == -1 {
            countdownLabel.text = activity
            timer.invalidate()
            repNum = 0
            repLabel.isHidden = false
            setLabel.isHidden = false
            statusLabel.isHidden = false
            backButton.barTintColor = UIColor.green
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WorkoutViewController.activityClock), userInfo: nil, repeats: true)
        }
    }
    
    @objc func activityClock() {
        numActivity -= 1
        countdownLabel.text = String(numActivity)
        pauseButton.isHidden = false
        pauseButton.isEnabled = true
        exersicing = true
        
        var alertSound = Bundle.main.path(forResource: "Censored_Beep-Mastercard-569981218", ofType: "mp3")
        var alertSound2 = Bundle.main.path(forResource: "Bleep-noise", ofType: "mp3")
        
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: alertSound!))
            audioPlayer.prepareToPlay()
            
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: alertSound2!))
            audioPlayer2.prepareToPlay()
            
            
        } catch {
            
            print(error)
            
        }
        
        if numActivity == 3 || numActivity == 2 || numActivity == 1 {
            
            audioPlayer.play()
            
        }
        
        if numActivity == 0 {
            
            audioPlayer2.play()
            
            repNum += 1
            repLabel.text = "Reps Done: \(repNum)/\(reps)"
            if repNum == Int(reps) {
                setNum += 1
                repNum = 0
                setLabel.text = "Sets Done: \(setNum)/\(sets)"
                repLabel.text = "Reps Done: \(repNum)/\(reps)"
                if setNum == Int(sets) {
                    countdownLabel.text = "Done!"
                    statusLabel.isHidden = true
                    pauseButton.isHidden = true
                    pauseButton.isEnabled = false
                    timer.invalidate()
                } else {
                    countdownLabel.text = "Rest!"
                    statusLabel.text = "Resting"
                    self.view.backgroundColor = UIColor(hexString: "e04e4e")
                    backButton.barTintColor = UIColor(hexString: "e04e4e")
                }
            } else {
                countdownLabel.text = "Rest!"
                statusLabel.text = "Resting"
                self.view.backgroundColor = UIColor(hexString: "e04e4e")
                backButton.barTintColor = UIColor(hexString: "e04e4e")
            }
        }
        if numActivity == -1 {
            pauseButton.isHidden = true
            pauseButton.isEnabled = false
            numRest = Int(rest)!
            timer.invalidate()
            countdownLabel.text = rest
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WorkoutViewController.restClock), userInfo: nil, repeats: true)
        }
    }
    
    @objc func restClock() {
        numRest -= 1
        countdownLabel.text = String(numRest)
        exersicing = false
        pauseButton.isHidden = false
        pauseButton.isEnabled = true
        
        var alertSound = Bundle.main.path(forResource: "Censored_Beep-Mastercard-569981218", ofType: "mp3")
        var alertSound2 = Bundle.main.path(forResource: "Bleep-noise", ofType: "mp3")
        
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: alertSound!))
            audioPlayer.prepareToPlay()
            
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: alertSound2!))
            audioPlayer2.prepareToPlay()
            
            
        } catch {
            
            print(error)
            
        }
        
        if numRest == 3 || numRest == 2 || numRest == 1 {
            
            audioPlayer.play()
            
        }
        
        if numRest == 0 {
            numActivity = Int(activity)!
            audioPlayer2.play()
            
            countdownLabel.text = "Go!"
            statusLabel.text = "Activity"
            self.view.backgroundColor = UIColor.green
            backButton.barTintColor = UIColor.green
            
        } else if numRest == -1 {
            timer.invalidate()
            pauseButton.isHidden = true
            pauseButton.isEnabled = false
            countdownLabel.text = "Go!"
            countdownLabel.text = activity
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WorkoutViewController.activityClock), userInfo: nil, repeats: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repLabel.isHidden = true
        setLabel.isHidden = true
        statusLabel.isHidden = true
        
        backButton.barTintColor = UIColor.green
        
        self.view.backgroundColor = UIColor.green
        
        numActivity = Int(activity)!
        numRest = Int(rest)!
        
        repLabel.text = "Reps Done: 0/\(reps)"
        setLabel.text = "Sets Done: 0/\(sets)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WorkoutViewController.clock), userInfo: nil, repeats: true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIToolbar) {
        timer.invalidate()
        performSegue(withIdentifier: "goBack", sender: self)
    }
    
    
    @IBAction func pauseButtonPressed() {
        
        if pause == false {
            timer.invalidate()
            pause = true
            print(pause)
            pauseButton.setImage(UIImage(named: "play"), for: .normal)
            
        } else {
            if exersicing == true {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WorkoutViewController.activityClock), userInfo: nil, repeats: true)
            } else if exersicing == false {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WorkoutViewController.restClock), userInfo: nil, repeats: true)
            }
            pause = false
            print(pause)
            pauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goBack" {
            timer.invalidate()
        }
    }
    
}
