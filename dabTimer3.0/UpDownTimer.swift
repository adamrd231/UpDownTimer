//
//  TimerOptions.swift
//  dabTimer3.0
//
//  Created by Adam Reed on 2/11/18.
//  Copyright © 2018 RD concepts. All rights reserved.
//

import UIKit

class UpDownTimer: NSObject {
    
    var name = ""
    var heatUpTimer = 45
    var heatTimerSaved = 45
    var timerIsRunning = false
    var coolDownTimer = 45
    var coolTimerSaved = 45
    
//    init(name: String, heatUpTimer: Int, heatTimerSaved: Int, coolDownTimer: Int, coolTimerSaved: Int, timerIsRunning: Bool) {
//
//        self.name = name
//        self.heatUpTimer = heatUpTimer
//        self.heatTimerSaved = heatTimerSaved
//        self.coolDownTimer = coolDownTimer
//        self.coolTimerSaved = coolTimerSaved
//        self.timerIsRunning = timerIsRunning
//
//    }
    
    
    var timer = Timer()
    
    
    //MARK:- Custom Functions
    // Reset the timers back to the default time.
    func resetTimers(timer: UpDownTimer, heat: UILabel, cool: UILabel) {
        
        timer.heatUpTimer = heatTimerSaved
        heat.text = String(heatUpTimer)
        
        timer.coolDownTimer = coolTimerSaved
        cool.text = String(coolDownTimer)
        
        timer.timerIsRunning = false
        timer.timer.invalidate()
        
    }
    
    func runTimers(upDownTimer: UpDownTimer, heat: UILabel, cool: UILabel) {
        // Run the Heat Up Timer
        if upDownTimer.heatUpTimer > 0 {
            upDownTimer.heatUpTimer -= 1
            heat.text = String(upDownTimer.heatUpTimer)
        }
        // If the heat timer is 0, then run the Cool Down Timer
        if upDownTimer.heatUpTimer == 0 && upDownTimer.coolDownTimer > 0 {
            upDownTimer.coolDownTimer -= 1
            cool.text = String(upDownTimer.coolDownTimer)

            // When the cool down timer reaches 0, invalidate the timer to end it.
            if upDownTimer.coolDownTimer == 0 {
                upDownTimer.timerIsRunning = false
                upDownTimer.timer.invalidate()
            }
        }
    }
           
        
 
}

    
    
//    // screen flash
//    func flash() {
//        if let wnd = self.view{
//
//            var v = UIView(frame: wnd.bounds)
//            v.backgroundColor = UIColor.white
//            v.alpha = 1
//
//            wnd.addSubview(v)
//            UIView.animate(withDuration: 1.0, animations: {
//                v.alpha = 0.0
//            }, completion: {(finished:Bool) in
//                print("inside")
//                v.removeFromSuperview()
//            })
//        }
//    }
    

