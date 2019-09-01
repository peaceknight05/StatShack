//
//  HandballScoreCounterVC.swift
//  StatShack
//
//  Created by Santhiyaa Senthilkumar on 8/5/19.
//  Copyright © 2019 Santhiyaa Senthilkumar. All rights reserved.
//

import UIKit

class HandballScoreCounterVC: UIViewController {
    // MARK: var
    
    @IBOutlet var mainClockLabel: UILabel!
    @IBOutlet weak var blueClockLabel: UILabel!
    @IBOutlet weak var redClockLabel: UILabel!
    var startTime: Date?
    var elapsedTime: TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow - pausedSeconds
        } else {
            return 0
        }
    }
    
//    var elapsedTimeRed: TimeInterval {
//        if let startTime = self.startTime {
//            var attempt = -startTime.timeIntervalSinceNow - pausedSecondsRed
//            if (attempt - (elapsedTime - elapsedTimeBlue) != 0) {
//                attempt -= attempt - (elapsedTime - elapsedTimeBlue)
//            }
//            return attempt
//        } else {
//            return 0
//        }
//    }
    
//    var elapsedTimeBlue: TimeInterval {
//        if let startTime = self.startTime {
//            var attempt = -startTime.timeIntervalSinceNow - pausedSecondsBlue
//            if (attempt - (elapsedTime - elapsedTimeRed) != 0) {
//                attempt -= attempt - (elapsedTime - elapsedTimeRed)
//            }
//            return attempt
//        } else {
//            return 0
//        }
//    }
    
    var possesion = Possesion.NONE
    var gameStart = false
    var timer: Timer?
    var timerR: Timer?
    var timerB: Timer?
    var isPaused = false
    var isPausedBlue = false
    var isPausedRed = false
    var pausedTimeBlue: Date?
    var pausedTimeRed: Date?
    var pausedTime: Date?
    var pausedIntervals: [TimeInterval] = []
    var pausedIntervalsRed: [TimeInterval] = []
    var pausedIntervalsBlue: [TimeInterval] = []
    var pausedSeconds: Double {
        var a = pausedIntervals.reduce(0) { $0 + $1 }
        if let pausedTimet = self.pausedTime {
            a += -pausedTimet.timeIntervalSinceNow
        }
        return a
    }
    
    //    var pausedSecondsRed: Double {
    //        var a = pausedIntervalsRed.reduce(0) { $0 + $1 }
    //        if let pausedTimet = self.pausedTimeRed {
    //            a += -pausedTimet.timeIntervalSinceNow
    //        }
    //        return a
    //    }
    
    //    var pausedSecondsBlue: Double {
    //        var a = pausedIntervalsBlue.reduce(0) { $0 + $1 }
    //        if let pausedTimet = self.pausedTimeBlue {
    //            a += -pausedTimet.timeIntervalSinceNow
    //        }
    //        return a
    //    }
    
    //    var elapsedTimeAsStringRed: String {
    //        return String(format: "%02d:%02d", Int(elapsedTimeRed / 60), Int(elapsedTimeRed.truncatingRemainder(dividingBy: TimeInterval(60))))
    //    }
    //
    //    var elapsedTimeAsStringBlue: String {
    //        return String(format: "%02d:%02d", Int(elapsedTimeBlue / 60), Int(elapsedTimeBlue.truncatingRemainder(dividingBy: TimeInterval(60))))
    //    }
    
    var isRunning = false
    var teamOneName: String?
    var teamtwoName: String?
    var teamOneNames: [Positions: String]?
    var teamTwoNames: [Positions: String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func startTimer() {
        pausedIntervals.append(pausedSeconds)
        pausedTime = nil
        
        isPaused = false
        isRunning = true
    }
    
    func stopTimer() {
        guard isRunning && !isPaused else {
            return
        }
        timer?.invalidate()
        //        timerB?.invalidate()
        //        timerR?.invalidate()
        isPaused = true
        isRunning = false
        pausedTime = Date()
    }
    
    @objc func updateElapsedTimeLabel() {
        if isRunning {
            mainClockLabel.text = String(format: "%02d:%02d", Int(elapsedTime / 60), Int(elapsedTime.truncatingRemainder(dividingBy: TimeInterval(60))))
        }
    }
    
    //    @objc func updateElapsedTimeLabelRed() {
    //        if isRunning && possesion == .RED {
    //            redClockLabel.text = elapsedTimeAsStringRed
    //        }
    //    }
    //
    //    @objc func updateElapsedTimeLabelBlue() {
    //        if isRunning && possesion == .BLUE {
    //            blueClockLabel.text = elapsedTimeAsStringBlue
    //        }
    //    }
    
    @IBAction func startStop(_ sender: Any) {
        guard gameStart else {
            return
        }
        
        if !isRunning {
            if !timer!.isValid {
                loadTimer()
            }
            //            if !timerR!.isValid {
            //                loadTimerR()
            //            }
            //            if !timerB!.isValid {
            //                loadTimerB()
            //            }
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    @IBAction func bluePC(_ sender: Any) {
        guard !isPaused else {
            return
        }
        
        if !gameStart {
            loadTimer()
            //            loadTimerB()
            //            loadTimerR()
            startTime = Date()
            possesion = .BLUE
            //            isPausedRed = true
            //            pausedTimeRed = Date()
            startTimer()
            gameStart = true
        } else {
            guard possesion != .BLUE else {
                return
            }
            
            //            pausedIntervalsBlue.append(pausedSecondsBlue)
            //            pausedTimeBlue = nil
            //
            //            pausedTimeRed = Date()
            
            possesion = .BLUE
            //            isPausedRed = true
            //            isPausedBlue = false
        }
    }
    
    @IBAction func redPC(_ sender: Any) {
        guard !isPaused else {
            return
        }
        
        if !gameStart {
            loadTimer()
            //            loadTimerB()
            //            loadTimerR()
            startTime = Date()
            possesion = .RED
            //            isPausedBlue = true
            //            pausedTimeBlue = Date()
            startTimer()
            gameStart = true
        } else {
            guard possesion != .RED else {
                return
            }
            
            //            pausedIntervalsRed.append(pausedSecondsRed)
            //            pausedTimeRed = nil
            //
            //            pausedTimeBlue = Date()
            
            possesion = .RED
            //            isPausedRed = false
            //            isPausedBlue = true
        }
    }
    
    func loadTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateElapsedTimeLabel), userInfo: nil, repeats: true)
    }
    
    //    func loadTimerR() {
    //        timerR = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateElapsedTimeLabelRed), userInfo: nil, repeats: true)
    //    }
    //
    //    func loadTimerB() {
    //        timerB = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateElapsedTimeLabelBlue), userInfo: nil, repeats: true)
    //    }
}

enum Positions {
    case GOALKEEPER
    case LEFT_WINGER
    case RIGHT_WINGER
    case LEFT_FULLBACK
    case RIGHT_FULLBACK
}

enum Possesion {
    case NONE
    case BLUE
    case RED
}
