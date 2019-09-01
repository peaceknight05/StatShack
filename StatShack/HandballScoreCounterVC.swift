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
    var startTime: Date?
    var elapsedTime: TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow - pausedSeconds
        } else {
            return 0
        }
    }

    var timer: Timer?
    var isPaused = false
    var pausedTime: Date?
    var pausedIntervals: [TimeInterval] = []
    var pausedSeconds: Double {
        var a = pausedIntervals.reduce(0) { $0 + $1 }
        if let pausedTime = pausedTime {
            a += -pausedTime.timeIntervalSinceNow
        }
        return a
    }

    var elapsedTimeAsString: String {
        return String(format: "%02d:%02d", Int(elapsedTime / 60), Int(elapsedTime.truncatingRemainder(dividingBy: TimeInterval(60))))
    }

    var isRunning = false
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
        isPaused = true
        isRunning = false
        pausedTime = Date()
    }

    @objc func updateElapsedTimeLabel() {
        if isRunning {
            mainClockLabel.text = elapsedTimeAsString
        }
    }

    @IBAction func startStop(_ sender: Any) {
        if !isRunning {
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateElapsedTimeLabel), userInfo: nil, repeats: true)
                startTime = Date()
            }
            startTimer()
        } else {
            stopTimer()
        }
    }
}

enum Positions {
    case GOALKEEPER
    case LEFT_WINGER
    case RIGHT_WINGER
    case LEFT_FULLBACK
    case RIGHT_FULLBACK
}
