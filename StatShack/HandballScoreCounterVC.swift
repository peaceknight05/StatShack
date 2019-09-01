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
    @IBOutlet var blueClockLabel: UILabel!
    @IBOutlet var redClockLabel: UILabel!

    @IBOutlet var bgkb: UIButton!
    @IBOutlet var brwb: UIButton!
    @IBOutlet var blwb: UIButton!
    @IBOutlet var brfb: UIButton!
    @IBOutlet var blfb: UIButton!
    @IBOutlet var rgkb: UIButton!
    @IBOutlet var rrwb: UIButton!
    @IBOutlet var rlwb: UIButton!
    @IBOutlet var rrfb: UIButton!
    @IBOutlet var rlfb: UIButton!

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
    var viewBGKRect: CGRect!
    var viewRGKRect: CGRect!
    var viewBGK: UIView!
    var viewRGK: UIView!

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

        bgkb.tag = 0
        rgkb.tag = 1

        brwb.tag = 0
        rrwb.tag = 2
        blwb.tag = 1
        rlwb.tag = 3

        brfb.tag = 0
        rrfb.tag = 2
        blfb.tag = 1
        rlfb.tag = 3
        
        viewBGKRect = CGRect(x: 20, y: 20, width: 984, height: 660)
        viewBGK = UIView(frame: viewBGKRect)
        viewBGK.backgroundColor = UIColor(red: 139.0, green: 206.0, blue: 231.0, alpha: 1.0)
        viewBGK.alpha = 1
        viewBGK.isOpaque = true
        
        viewRGKRect = CGRect(x: 20, y: 20, width: 984, height: 660)
        viewRGK = UIView(frame: viewRGKRect)
        viewRGK.backgroundColor = UIColor(red: 240.0, green: 177.0, blue: 187.0, alpha: 1.0)
        viewRGK.alpha = 1
        viewRGK.isOpaque = true
        
        viewBGK.isHidden = true
        viewRGK.isHidden = true
        
        view.addSubview(viewBGK)
        view.addSubview(viewRGK)
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
    
    var gkBShow = false
    var gkRShow = false
    var rwBShow = false
    var rwRShow = false
    var lwBShow = false
    var lwRShow = false
    var rfBShow = false
    var rfRShow = false
    var lfBShow = false
    var lfRShow = false
    
    
    @IBAction func goalkeeper(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            // blue
            guard !gkBShow else {
                return
            }
            
            viewBGK.isHidden = false
            viewRGK.isHidden = true
            
            gkBShow = true
            gkRShow = false
            rwBShow = false
            rwRShow = false
            lwBShow = false
            lwRShow = false
            rfBShow = false
            rfRShow = false
            lfBShow = false
            lfRShow = false
            return
        default:
            // red
            guard !gkRShow else {
                return
            }
            
            viewBGK.isHidden = true
            viewRGK.isHidden = false
            
            gkBShow = false
            gkRShow = true
            rwBShow = false
            rwRShow = false
            lwBShow = false
            lwRShow = false
            rfBShow = false
            rfRShow = false
            lfBShow = false
            lfRShow = false
            return
        }
    }

    @IBAction func winger(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            return
            // blue right
        case 1:
            return
            // blue left
        case 2:
            return
            // red right
        default:
            return
            // red left
        }
    }

    @IBAction func fullback(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            return
            // blue right
        case 1:
            return
            // blue left
        case 2:
            return
            // red right
        default:
            return
            // red left
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

enum Possesion {
    case NONE
    case BLUE
    case RED
}
