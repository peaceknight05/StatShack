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
    var elapsedTime: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            elapsedTime += 1
            
            mainClockLabel.text = String(format: "%02d:%02d", Int(elapsedTime / 60), Int(elapsedTime - (elapsedTime / 60) * 60))
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
        }
    }
    
    @IBAction func bluePC(_ sender: Any) {
        guard !isPaused else {
            return
        }
        
        if !gameStart {
            loadTimer()
        
            possesion = .BLUE

            startTimer()
            gameStart = true
        } else {
            guard possesion != .BLUE else {
                return
            }
            
            possesion = .BLUE

        }
    }
    
    @IBAction func redPC(_ sender: Any) {
        guard !isPaused else {
            return
        }
        
        if !gameStart {
            loadTimer()

            possesion = .RED

            startTimer()
            gameStart = true
        } else {
            guard possesion != .RED else {
                return
            }
            
            possesion = .RED

        }
    }
    
    func loadTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateElapsedTimeLabel), userInfo: nil, repeats: true)
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
