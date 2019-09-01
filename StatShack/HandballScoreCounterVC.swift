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
    
    @IBOutlet weak var bgkb: UIButton!
    @IBOutlet weak var brwb: UIButton!
    @IBOutlet weak var blwb: UIButton!
    @IBOutlet weak var brfb: UIButton!
    @IBOutlet weak var blfb: UIButton!
    @IBOutlet weak var rgkb: UIButton!
    @IBOutlet weak var rrwb: UIButton!
    @IBOutlet weak var rlwb: UIButton!
    @IBOutlet weak var rrfb: UIButton!
    @IBOutlet weak var rlfb: UIButton!
    
    var possesion = Possesion.NONE
    var gameStart = false
    var timer: Timer?
    var timerR: Timer?
    var timerB: Timer?
    var isPaused = false
    var isPausedBlue = false
    var isPausedRed = false
    var isRunning = false
    var teamOneName: String?
    var teamtwoName: String?
    var teamOneNames: [Positions: String]?
    var teamTwoNames: [Positions: String]?
    var elapsedTime: Double = 0.0
    var elapsedTimeR: Double = 0.0
    var elapsedTimeB: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !(teamOneNames![.GOALKEEPER]! == "") {
            bgkb.setTitle(teamOneNames![.GOALKEEPER]!, for: .normal)
        }
        if !(teamOneNames![.RIGHT_WINGER]! == "") {
            brwb.setTitle(teamOneNames![.RIGHT_WINGER]!, for: .normal)
        }
        if !(teamOneNames![.LEFT_WINGER]! == "") {
            blwb.setTitle(teamOneNames![.LEFT_WINGER]!, for: .normal)
        }
        if !(teamOneNames![.RIGHT_FULLBACK]! == "") {
            brfb.setTitle(teamOneNames![.RIGHT_FULLBACK]!, for: .normal)
        }
        if !(teamOneNames![.LEFT_FULLBACK]! == "") {
            blfb.setTitle(teamOneNames![.LEFT_FULLBACK]!, for: .normal)
        }
        if !(teamTwoNames![.GOALKEEPER]! == "") {
            rgkb.setTitle(teamTwoNames![.GOALKEEPER]!, for: .normal)
        }
        if !(teamTwoNames![.RIGHT_WINGER]! == "") {
            rrwb.setTitle(teamTwoNames![.RIGHT_WINGER]!, for: .normal)
        }
        if !(teamTwoNames![.LEFT_WINGER]! == "") {
            rlwb.setTitle(teamTwoNames![.LEFT_WINGER]!, for: .normal)
        }
        if !(teamTwoNames![.RIGHT_FULLBACK]! == "") {
            rrfb.setTitle(teamTwoNames![.RIGHT_FULLBACK]!, for: .normal)
        }
        if !(teamTwoNames![.LEFT_FULLBACK]! == "") {
            rlfb.setTitle(teamTwoNames![.LEFT_FULLBACK]!, for: .normal)
        }
    }
    
    func startTimer() {
        
        isPaused = false
        isRunning = true
    }
    
    func stopTimer() {
        timer?.invalidate()

        isPaused = true
        isRunning = false
    }
    
    @objc func updateElapsedTimeLabel() {
        if isRunning {
            elapsedTime += 0.1
            
            mainClockLabel.text = String(format: "%02d:%02d", Int(elapsedTime / 60), Int(elapsedTime.truncatingRemainder(dividingBy: 60)))
        }
    }
    
    @objc func updateElapsedTimeLabelR() {
        if isRunning {
            elapsedTimeR += 0.1
            
            redClockLabel.text = String(format: "%02d:%02d", Int(elapsedTimeR / 60), Int(elapsedTimeR.truncatingRemainder(dividingBy: 60)))
        }
    }
    
    @objc func updateElapsedTimeLabelB() {
        if isRunning {
            elapsedTimeB += 0.1
            
            blueClockLabel.text = String(format: "%02d:%02d", Int(elapsedTimeB / 60), Int(elapsedTimeB.truncatingRemainder(dividingBy: 60)))
        }
    }
    
    @IBAction func startStop(_ sender: Any) {
        guard gameStart else {
            return
        }
        
        if isPaused {
            if !timer!.isValid {
                loadTimer()
            }
            startTimer()
        } else {
            stopTimer()
            timerB?.invalidate()
            timerR?.invalidate()
        }
    }
    
    @IBAction func bluePC(_ sender: Any) {
        guard !isPaused else {
            return
        }
        
        if !gameStart {
            loadTimer()
            loadBlueTimer()
            possesion = .BLUE
            isPausedRed = true
            startTimer()
            gameStart = true
        } else {
            guard possesion != .BLUE else {
                return
            }
            
            loadBlueTimer()
            timerR?.invalidate()
            isPausedBlue = false
            isPausedRed = true
            possesion = .BLUE

        }
    }
    
    @IBAction func redPC(_ sender: Any) {
        guard !isPaused else {
            return
        }
        
        if !gameStart {
            loadTimer()
            loadRedTimer()
            possesion = .RED
            isPausedBlue = true
            startTimer()
            gameStart = true
        } else {
            guard possesion != .RED else {
                return
            }
            
            loadRedTimer()
            timerB?.invalidate()
            possesion = .RED
            isPausedRed = false
            isPausedBlue = false
        }
    }
    
    func loadTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateElapsedTimeLabel), userInfo: nil, repeats: true)
    }
    
    func loadBlueTimer() {
        timerB = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateElapsedTimeLabelB), userInfo: nil, repeats: true)
    }
    
    func loadRedTimer() {
        timerR = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateElapsedTimeLabelR), userInfo: nil, repeats: true)
    }
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
