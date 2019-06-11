//
//  StopWatchVC.swift
//  Stopwatch
//
//  Created by John Crites on 6/4/19.
//  Copyright © 2019 JCDev. All rights reserved.
//

import UIKit

class StopWatchVC: UIViewController {
    
    var counter = 0.0
    var timer = Timer()
    var isInitialized = false
    
    @IBOutlet weak var timerWindow: UILabel!
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    @IBOutlet weak var buttonReset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerWindow.text = String(counter)
        
        //reset button properties
        buttonReset.layer.cornerRadius = 10.0
        buttonReset.layer.masksToBounds = true
        //buttonReset.isEnabled = false
        buttonReset.alpha = 0.5
        
        //start button properties
        buttonStart.layer.cornerRadius = 10.0
        buttonStart.layer.masksToBounds = true
        
        //stop button properties
        buttonStop.layer.cornerRadius = 10.0
        buttonStop.layer.masksToBounds = true
        buttonStop.isEnabled = false
        buttonStop.alpha = 0.5
        
    }
    
    @IBAction func toStopTimer(_ sender: Any) {
        buttonStart.isEnabled = true
        buttonStop.isEnabled = false
        
        timer.invalidate()
        isInitialized = false
        
        buttonReset.alpha = 1.0
        buttonStart.alpha = 1.0
        buttonStop.alpha = 0.5
    }
    
    @IBAction func toStartTimer(_ sender: Any) {
        if (isInitialized) {
            return
        }
        buttonStart.isEnabled = false
        buttonStop.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(currentTimer), userInfo: nil, repeats: true)
        isInitialized = true
        
        buttonReset.alpha = 1.0
        buttonStart.alpha = 0.5
        buttonStop.alpha = 1.0
    }
    
    @IBAction func toResetTimer(_ sender: Any) {
        buttonStart.isEnabled = true
        buttonStop.isEnabled = false
        
        timer.invalidate()
        isInitialized = false
        counter = 0.0
        timerWindow.text = String(counter)
        
        buttonReset.alpha = 0.5
        buttonStart.alpha = 1.0
        buttonStop.alpha = 0.5
    }
    
    @objc func currentTimer() {
        counter += 0.1
        timerWindow.text = "\(counter)"
        
        //computed properties
        //HH:MM:SS.MS
        
        let counter_floor = Int(floor(counter))
        let hours = counter_floor / 3600
        let minutes = (counter_floor % 3600) / 60
        var counterMinute = "\(minutes)"
        if minutes < 10 {
            counterMinute = "0\(minutes)"
        }
        
        let seconds = (counter_floor % 3600) % 60
        var counterSecond = "\(seconds)"
        if seconds < 10 {
            counterSecond = "0\(seconds)"
        }
        
        let deciseconds = String(format: "%.1f", counter).components(separatedBy: ".").last!
        
        timerWindow.text = "\(hours):\(counterMinute):\(counterSecond).\(deciseconds)"
    }
}
