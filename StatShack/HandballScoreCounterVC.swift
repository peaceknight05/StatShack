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

    // name: data
    // shotsLetIn shotsCaught shotsBlocked
    var goalieStats: [String: [Int]] = [:]
    // shotsAttempted shotsScored passesIntercepted
    var playerStats: [String: [Int]] = [:]

    var teamOneScore = 0
    var teamTwoScore = 0

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
    var teamTwoName: String?
    var teamOneNames: [Positions: String]?
    var teamTwoNames: [Positions: String]?
    var elapsedTime: Double = 0.0
    var elapsedTimeR: Double = 0.0
    var elapsedTimeB: Double = 0.0
    var viewBGKRect: CGRect!
    var viewRGKRect: CGRect!
    var viewBGK: UIView!
    var viewRGK: UIView!
    var viewBRWRect: CGRect!
    var viewRRWRect: CGRect!
    var viewBRW: UIView!
    var viewRRW: UIView!
    var viewBLWRect: CGRect!
    var viewRLWRect: CGRect!
    var viewBLW: UIView!
    var viewRLW: UIView!
    var viewBRFRect: CGRect!
    var viewRRFRect: CGRect!
    var viewBRF: UIView!
    var viewRRF: UIView!
    var viewBLFRect: CGRect!
    var viewRLFRect: CGRect!
    var viewBLF: UIView!
    var viewRLF: UIView!
    var titleBGK: UILabel!
    var titleRGK: UILabel!
    var titleBRW: UILabel!
    var titleRRW: UILabel!
    var titleBLW: UILabel!
    var titleRLW: UILabel!
    var titleBRF: UILabel!
    var titleRRF: UILabel!
    var titleBLF: UILabel!
    var titleRLF: UILabel!
    var shotsLetInBGK: UIButton!
    var shotsLetInRGK: UIButton!
    var shotsCaughtBGK: UIButton!
    var shotsCaughtRGK: UIButton!
    var shotsBlockedBGK: UIButton!
    var shotsBlockedRGK: UIButton!
    var shotsAttemptedBRW: UIButton!
    var shotsScoredBRW: UIButton!
    var passesInterceptedBRW: UIButton!
    var shotsAttemptedBLW: UIButton!
    var shotsScoredBLW: UIButton!
    var passesInterceptedBLW: UIButton!
    var shotsAttemptedBRF: UIButton!
    var shotsScoredBRF: UIButton!
    var passesInterceptedBRF: UIButton!
    var shotsAttemptedBLF: UIButton!
    var shotsScoredBLF: UIButton!
    var passesInterceptedBLF: UIButton!
    var shotsAttemptedRRW: UIButton!
    var shotsScoredRRW: UIButton!
    var passesInterceptedRRW: UIButton!
    var shotsAttemptedRLW: UIButton!
    var shotsScoredRLW: UIButton!
    var passesInterceptedRLW: UIButton!
    var shotsAttemptedRRF: UIButton!
    var shotsScoredRRF: UIButton!
    var passesInterceptedRRF: UIButton!
    var shotsAttemptedRLF: UIButton!
    var shotsScoredRLF: UIButton!
    var passesInterceptedRLF: UIButton!
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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "0:0"

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

        for name in teamOneNames! {
            if name.key == .GOALKEEPER {
                if name.value == "" {
                    goalieStats["GK (Blue)"] = [0, 0, 0]
                } else {
                    goalieStats["\(name.value) (Blue)"] = [0, 0, 0]
                }
            } else {
                if name.value == "" {
                    playerStats["\(name.key.toShort()) (Blue)"] = [0, 0, 0]
                } else {
                    playerStats["\(name.value) (Blue)"] = [0, 0, 0]
                }
            }
        }

        for name in teamTwoNames! {
            if name.key == .GOALKEEPER {
                if name.value == "" {
                    goalieStats["GK (Red)"] = [0, 0, 0]
                } else {
                    goalieStats["\(name.value) (Red)"] = [0, 0, 0]
                }
            } else {
                if name.value == "" {
                    playerStats["\(name.key.toShort()) (Red)"] = [0, 0, 0]
                } else {
                    playerStats["\(name.value) (Red)"] = [0, 0, 0]
                }
            }
        }

        bgkb.tag = 0
        rgkb.tag = 1

        brwb.tag = 0
        rrwb.tag = 1
        blwb.tag = 2
        rlwb.tag = 3

        brfb.tag = 0
        rrfb.tag = 1
        blfb.tag = 2
        rlfb.tag = 3

        viewBGKRect = CGRect(x: 20, y: 80, width: 984, height: 660)
        viewBGK = UIView(frame: viewBGKRect)
        viewBGK.backgroundColor = UIColor(red: 0.55, green: 0.81, blue: 0.91, alpha: 1.0)

        titleBGK = UILabel(frame: CGRect(x: 0, y: 20, width: 984, height: 60))
        titleBGK.text = bgkb.title(for: .normal)
        titleBGK.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 35), size: 35)
        titleBGK.textAlignment = .center
        viewBGK.addSubview(titleBGK)

        shotsLetInBGK = UIButton(frame: CGRect(x: 20, y: 100, width: 944, height: 100))
        shotsLetInBGK.setTitle("Shots Let In", for: .normal)
        shotsLetInBGK.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsLetInBGK.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        shotsLetInBGK.addTarget(self, action: #selector(shotsLetInBlue(sender:)), for: .touchUpInside)
        viewBGK.addSubview(shotsLetInBGK)

        shotsCaughtBGK = UIButton(frame: CGRect(x: 20, y: 240, width: 944, height: 100))
        shotsCaughtBGK.setTitle("Shots Caught", for: .normal)
        shotsCaughtBGK.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsCaughtBGK.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        shotsCaughtBGK.addTarget(self, action: #selector(shotsCaughtBlue(sender:)), for: .touchUpInside)
        viewBGK.addSubview(shotsCaughtBGK)

        shotsBlockedBGK = UIButton(frame: CGRect(x: 20, y: 380, width: 944, height: 100))
        shotsBlockedBGK.setTitle("Shots Blocked", for: .normal)
        shotsBlockedBGK.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsBlockedBGK.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        shotsBlockedBGK.addTarget(self, action: #selector(shotsBlockedBlue(sender:)), for: .touchUpInside)
        viewBGK.addSubview(shotsBlockedBGK)

        viewRGKRect = CGRect(x: 20, y: 80, width: 984, height: 660)
        viewRGK = UIView(frame: viewRGKRect)
        viewRGK.backgroundColor = UIColor(red: 0.94, green: 0.69, blue: 0.73, alpha: 1.0)

        titleRGK = UILabel(frame: CGRect(x: 0, y: 20, width: 984, height: 60))
        titleRGK.text = rgkb.title(for: .normal)
        titleRGK.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 35), size: 35)
        titleRGK.textAlignment = .center
        viewRGK.addSubview(titleRGK)

        shotsLetInRGK = UIButton(frame: CGRect(x: 20, y: 100, width: 944, height: 100))
        shotsLetInRGK.setTitle("Shots Let In", for: .normal)
        shotsLetInRGK.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsLetInRGK.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        shotsLetInRGK.addTarget(self, action: #selector(shotsLetInRed(sender:)), for: .touchUpInside)
        viewRGK.addSubview(shotsLetInRGK)

        shotsCaughtRGK = UIButton(frame: CGRect(x: 20, y: 240, width: 944, height: 100))
        shotsCaughtRGK.setTitle("Shots Caught", for: .normal)
        shotsCaughtRGK.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsCaughtRGK.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        shotsCaughtRGK.addTarget(self, action: #selector(shotsCaughtRed(sender:)), for: .touchUpInside)
        viewRGK.addSubview(shotsCaughtRGK)

        shotsBlockedRGK = UIButton(frame: CGRect(x: 20, y: 380, width: 944, height: 100))
        shotsBlockedRGK.setTitle("Shots Blocked", for: .normal)
        shotsBlockedRGK.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsBlockedRGK.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        shotsBlockedRGK.addTarget(self, action: #selector(shotsBlockedRed(sender:)), for: .touchUpInside)
        viewRGK.addSubview(shotsBlockedRGK)

        viewBRWRect = CGRect(x: 20, y: 80, width: 984, height: 660)
        viewBRW = UIView(frame: viewBGKRect)
        viewBRW.backgroundColor = UIColor(red: 0.55, green: 0.81, blue: 0.91, alpha: 1.0)

        titleBRW = UILabel(frame: CGRect(x: 0, y: 20, width: 984, height: 60))
        titleBRW.text = brwb.title(for: .normal)
        titleBRW.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 35), size: 35)
        titleBRW.textAlignment = .center
        viewBRW.addSubview(titleBRW)

        shotsAttemptedBRW = UIButton(frame: CGRect(x: 20, y: 100, width: 944, height: 100))
        shotsAttemptedBRW.setTitle("Shots Attempted", for: .normal)
        shotsAttemptedBRW.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsAttemptedBRW.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        shotsAttemptedBRW.addTarget(self, action: #selector(shotsAttemptedRWBlue(sender:)), for: .touchUpInside)
        viewBRW.addSubview(shotsAttemptedBRW)

        shotsScoredBRW = UIButton(frame: CGRect(x: 20, y: 240, width: 944, height: 100))
        shotsScoredBRW.setTitle("Shots Scored", for: .normal)
        shotsScoredBRW.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsScoredBRW.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        shotsScoredBRW.addTarget(self, action: #selector(shotsScoredRWBlue(sender:)), for: .touchUpInside)
        viewBRW.addSubview(shotsScoredBRW)

        passesInterceptedBRW = UIButton(frame: CGRect(x: 20, y: 380, width: 944, height: 100))
        passesInterceptedBRW.setTitle("Passes Intercepted", for: .normal)
        passesInterceptedBRW.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        passesInterceptedBRW.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        passesInterceptedBRW.addTarget(self, action: #selector(passesInterceptedRWBlue(sender:)), for: .touchUpInside)
        viewBRW.addSubview(passesInterceptedBRW)

        viewRRWRect = CGRect(x: 20, y: 80, width: 984, height: 660)
        viewRRW = UIView(frame: viewRGKRect)
        viewRRW.backgroundColor = UIColor(red: 0.94, green: 0.69, blue: 0.73, alpha: 1.0)
        titleRRW = UILabel(frame: CGRect(x: 0, y: 20, width: 984, height: 60))
        titleRRW.text = rrwb.title(for: .normal)
        titleRRW.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 35), size: 35)
        titleRRW.textAlignment = .center
        viewRRW.addSubview(titleRRW)

        shotsAttemptedRRW = UIButton(frame: CGRect(x: 20, y: 100, width: 944, height: 100))
        shotsAttemptedRRW.setTitle("Shots Attempted", for: .normal)
        shotsAttemptedRRW.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsAttemptedRRW.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        shotsAttemptedRRW.addTarget(self, action: #selector(shotsAttemptedRWRed(sender:)), for: .touchUpInside)
        viewRRW.addSubview(shotsAttemptedRRW)

        shotsScoredRRW = UIButton(frame: CGRect(x: 20, y: 240, width: 944, height: 100))
        shotsScoredRRW.setTitle("Shots Scored", for: .normal)
        shotsScoredRRW.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsScoredRRW.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        shotsScoredRRW.addTarget(self, action: #selector(shotsScoredRWRed(sender:)), for: .touchUpInside)
        viewRRW.addSubview(shotsScoredRRW)

        passesInterceptedRRW = UIButton(frame: CGRect(x: 20, y: 380, width: 944, height: 100))
        passesInterceptedRRW.setTitle("Passes Intercepted", for: .normal)
        passesInterceptedRRW.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        passesInterceptedRRW.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        passesInterceptedRRW.addTarget(self, action: #selector(passesInterceptedRWRed(sender:)), for: .touchUpInside)
        viewRRW.addSubview(passesInterceptedRRW)

        viewBLWRect = CGRect(x: 20, y: 80, width: 984, height: 660)
        viewBLW = UIView(frame: viewBGKRect)
        viewBLW.backgroundColor = UIColor(red: 0.55, green: 0.81, blue: 0.91, alpha: 1.0)

        titleBLW = UILabel(frame: CGRect(x: 0, y: 20, width: 984, height: 60))
        titleBLW.text = blwb.title(for: .normal)
        titleBLW.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 35), size: 35)
        titleBLW.textAlignment = .center
        viewBLW.addSubview(titleBLW)

        shotsAttemptedBLW = UIButton(frame: CGRect(x: 20, y: 100, width: 944, height: 100))
        shotsAttemptedBLW.setTitle("Shots Attempted", for: .normal)
        shotsAttemptedBLW.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsAttemptedBLW.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        shotsAttemptedBLW.addTarget(self, action: #selector(shotsAttemptedLWBlue(sender:)), for: .touchUpInside)
        viewBLW.addSubview(shotsAttemptedBLW)

        shotsScoredBLW = UIButton(frame: CGRect(x: 20, y: 240, width: 944, height: 100))
        shotsScoredBLW.setTitle("Shots Scored", for: .normal)
        shotsScoredBLW.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsScoredBLW.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        shotsScoredBLW.addTarget(self, action: #selector(shotsScoredLWBlue(sender:)), for: .touchUpInside)
        viewBLW.addSubview(shotsScoredBLW)

        passesInterceptedBLW = UIButton(frame: CGRect(x: 20, y: 380, width: 944, height: 100))
        passesInterceptedBLW.setTitle("Passes Intercepted", for: .normal)
        passesInterceptedBLW.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        passesInterceptedBLW.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        passesInterceptedBLW.addTarget(self, action: #selector(passesInterceptedLWBlue(sender:)), for: .touchUpInside)
        viewBLW.addSubview(passesInterceptedBLW)

        viewRLWRect = CGRect(x: 20, y: 80, width: 984, height: 660)
        viewRLW = UIView(frame: viewRGKRect)
        viewRLW.backgroundColor = UIColor(red: 0.94, green: 0.69, blue: 0.73, alpha: 1.0)

        titleRLW = UILabel(frame: CGRect(x: 0, y: 20, width: 984, height: 60))
        titleRLW.text = rlwb.title(for: .normal)
        titleRLW.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 35), size: 35)
        titleRLW.textAlignment = .center
        viewRLW.addSubview(titleRLW)

        shotsAttemptedRLW = UIButton(frame: CGRect(x: 20, y: 100, width: 944, height: 100))
        shotsAttemptedRLW.setTitle("Shots Attempted", for: .normal)
        shotsAttemptedRLW.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsAttemptedRLW.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        shotsAttemptedRLW.addTarget(self, action: #selector(shotsAttemptedLWRed(sender:)), for: .touchUpInside)
        viewRLW.addSubview(shotsAttemptedRLW)

        shotsScoredRLW = UIButton(frame: CGRect(x: 20, y: 240, width: 944, height: 100))
        shotsScoredRLW.setTitle("Shots Scored", for: .normal)
        shotsScoredRLW.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsScoredRLW.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        shotsScoredRLW.addTarget(self, action: #selector(shotsScoredLWRed(sender:)), for: .touchUpInside)
        viewRLW.addSubview(shotsScoredRLW)

        passesInterceptedRLW = UIButton(frame: CGRect(x: 20, y: 380, width: 944, height: 100))
        passesInterceptedRLW.setTitle("Passes Intercepted", for: .normal)
        passesInterceptedRLW.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        passesInterceptedRLW.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        passesInterceptedRLW.addTarget(self, action: #selector(passesInterceptedLWRed(sender:)), for: .touchUpInside)
        viewRLW.addSubview(passesInterceptedRLW)

        viewBRFRect = CGRect(x: 20, y: 80, width: 984, height: 660)
        viewBRF = UIView(frame: viewBGKRect)
        viewBRF.backgroundColor = UIColor(red: 0.55, green: 0.81, blue: 0.91, alpha: 1.0)

        titleBRF = UILabel(frame: CGRect(x: 0, y: 20, width: 984, height: 60))
        titleBRF.text = brfb.title(for: .normal)
        titleBRF.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 35), size: 35)
        titleBRF.textAlignment = .center
        viewBRF.addSubview(titleBRF)

        shotsAttemptedBRF = UIButton(frame: CGRect(x: 20, y: 100, width: 944, height: 100))
        shotsAttemptedBRF.setTitle("Shots Attempted", for: .normal)
        shotsAttemptedBRF.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsAttemptedBRF.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        shotsAttemptedBRF.addTarget(self, action: #selector(shotsAttemptedRFBlue(sender:)), for: .touchUpInside)
        viewBRF.addSubview(shotsAttemptedBRF)

        shotsScoredBRF = UIButton(frame: CGRect(x: 20, y: 240, width: 944, height: 100))
        shotsScoredBRF.setTitle("Shots Scored", for: .normal)
        shotsScoredBRF.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsScoredBRF.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        shotsScoredBRF.addTarget(self, action: #selector(shotsScoredRFBlue(sender:)), for: .touchUpInside)
        viewBRF.addSubview(shotsScoredBRF)

        passesInterceptedBRF = UIButton(frame: CGRect(x: 20, y: 380, width: 944, height: 100))
        passesInterceptedBRF.setTitle("Passes Intercepted", for: .normal)
        passesInterceptedBRF.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        passesInterceptedBRF.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        passesInterceptedBRF.addTarget(self, action: #selector(passesInterceptedRFBlue(sender:)), for: .touchUpInside)
        viewBRF.addSubview(passesInterceptedBRF)

        viewRRFRect = CGRect(x: 20, y: 80, width: 984, height: 660)
        viewRRF = UIView(frame: viewRGKRect)
        viewRRF.backgroundColor = UIColor(red: 0.94, green: 0.69, blue: 0.73, alpha: 1.0)

        titleRRF = UILabel(frame: CGRect(x: 0, y: 20, width: 984, height: 60))
        titleRRF.text = rrfb.title(for: .normal)
        titleRRF.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 35), size: 35)
        titleRRF.textAlignment = .center
        viewRRF.addSubview(titleRRF)

        shotsAttemptedRRF = UIButton(frame: CGRect(x: 20, y: 100, width: 944, height: 100))
        shotsAttemptedRRF.setTitle("Shots Attempted", for: .normal)
        shotsAttemptedRRF.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsAttemptedRRF.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        shotsAttemptedRRF.addTarget(self, action: #selector(shotsAttemptedRFRed(sender:)), for: .touchUpInside)
        viewRRF.addSubview(shotsAttemptedRRF)

        shotsScoredRRF = UIButton(frame: CGRect(x: 20, y: 240, width: 944, height: 100))
        shotsScoredRRF.setTitle("Shots Scored", for: .normal)
        shotsScoredRRF.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsScoredRRF.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        shotsScoredRRF.addTarget(self, action: #selector(shotsScoredRFRed(sender:)), for: .touchUpInside)
        viewRRF.addSubview(shotsScoredRRF)

        passesInterceptedRRF = UIButton(frame: CGRect(x: 20, y: 380, width: 944, height: 100))
        passesInterceptedRRF.setTitle("Passes Intercepted", for: .normal)
        passesInterceptedRRF.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        passesInterceptedRRF.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        passesInterceptedRRF.addTarget(self, action: #selector(passesInterceptedRFRed(sender:)), for: .touchUpInside)
        viewRRF.addSubview(passesInterceptedRRF)

        viewBLFRect = CGRect(x: 20, y: 80, width: 984, height: 660)
        viewBLF = UIView(frame: viewBGKRect)
        viewBLF.backgroundColor = UIColor(red: 0.55, green: 0.81, blue: 0.91, alpha: 1.0)

        titleBLF = UILabel(frame: CGRect(x: 0, y: 20, width: 984, height: 60))
        titleBLF.text = blfb.title(for: .normal)
        titleBLF.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 35), size: 35)
        titleBLF.textAlignment = .center
        viewBLF.addSubview(titleBLF)

        shotsAttemptedBLF = UIButton(frame: CGRect(x: 20, y: 100, width: 944, height: 100))
        shotsAttemptedBLF.setTitle("Shots Attempted", for: .normal)
        shotsAttemptedBLF.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsAttemptedBLF.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        shotsAttemptedBLF.addTarget(self, action: #selector(shotsAttemptedLFBlue(sender:)), for: .touchUpInside)
        viewBLF.addSubview(shotsAttemptedBLF)

        shotsScoredBLF = UIButton(frame: CGRect(x: 20, y: 240, width: 944, height: 100))
        shotsScoredBLF.setTitle("Shots Scored", for: .normal)
        shotsScoredBLF.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsScoredBLF.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        shotsScoredBLF.addTarget(self, action: #selector(shotsScoredLFBlue(sender:)), for: .touchUpInside)
        viewBLF.addSubview(shotsScoredBLF)

        passesInterceptedBLF = UIButton(frame: CGRect(x: 20, y: 380, width: 944, height: 100))
        passesInterceptedBLF.setTitle("Passes Intercepted", for: .normal)
        passesInterceptedBLF.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        passesInterceptedBLF.backgroundColor = UIColor(red: 0.64, green: 0.90, blue: 1.0, alpha: 1.0)
        passesInterceptedBLF.addTarget(self, action: #selector(passesInterceptedLFBlue(sender:)), for: .touchUpInside)
        viewBLF.addSubview(passesInterceptedBLF)

        viewRLFRect = CGRect(x: 20, y: 80, width: 984, height: 660)
        viewRLF = UIView(frame: viewRGKRect)
        viewRLF.backgroundColor = UIColor(red: 0.94, green: 0.69, blue: 0.73, alpha: 1.0)

        titleRLF = UILabel(frame: CGRect(x: 0, y: 20, width: 984, height: 60))
        titleRLF.text = rlfb.title(for: .normal)
        titleRLF.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 35), size: 35)
        titleRLF.textAlignment = .center
        viewRLF.addSubview(titleRLF)

        shotsAttemptedRLF = UIButton(frame: CGRect(x: 20, y: 100, width: 944, height: 100))
        shotsAttemptedRLF.setTitle("Shots Attempted", for: .normal)
        shotsAttemptedRLF.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsAttemptedRLF.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        shotsAttemptedRLF.addTarget(self, action: #selector(shotsAttemptedLFRed(sender:)), for: .touchUpInside)
        viewRLF.addSubview(shotsAttemptedRLF)

        shotsScoredRLF = UIButton(frame: CGRect(x: 20, y: 240, width: 944, height: 100))
        shotsScoredRLF.setTitle("Shots Scored", for: .normal)
        shotsScoredRLF.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        shotsScoredRLF.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        shotsScoredRLF.addTarget(self, action: #selector(shotsScoredLFRed(sender:)), for: .touchUpInside)
        viewRLF.addSubview(shotsScoredRLF)

        passesInterceptedRLF = UIButton(frame: CGRect(x: 20, y: 380, width: 944, height: 100))
        passesInterceptedRLF.setTitle("Passes Intercepted", for: .normal)
        passesInterceptedRLF.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 30), size: 30)
        passesInterceptedRLF.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.85, alpha: 1.0)
        passesInterceptedRLF.addTarget(self, action: #selector(passesInterceptedRFRed(sender:)), for: .touchUpInside)
        viewRLF.addSubview(passesInterceptedRLF)

        viewBGK.isHidden = true
        viewRGK.isHidden = true
        viewBRW.isHidden = true
        viewRRW.isHidden = true
        viewBLW.isHidden = true
        viewRLW.isHidden = true
        viewBRF.isHidden = true
        viewRRF.isHidden = true
        viewBLF.isHidden = true
        viewRLF.isHidden = true

        view.addSubview(viewBGK)
        view.addSubview(viewRGK)
        view.addSubview(viewBRW)
        view.addSubview(viewRRW)
        view.addSubview(viewBLW)
        view.addSubview(viewRLW)
        view.addSubview(viewBRF)
        view.addSubview(viewRRF)
        view.addSubview(viewBLF)
        view.addSubview(viewRLF)
    }

    @objc func shotsLetInBlue(sender: UIButton!) {
        let name = bgkb.titleLabel?.text!
        if goalieStats[name! + " (Blue)"] == nil {
            goalieStats[name! + " (Blue)"] = [1, 0, 0]
        } else {
            goalieStats[name! + " (Blue)"]![0] += 1
        }
    }

    @objc func shotsLetInRed(sender: UIButton!) {
        let name = rgkb.titleLabel?.text!
        if goalieStats[name! + " (Red)"] == nil {
            goalieStats[name! + " (Red)"] = [1, 0, 0]
        } else {
            goalieStats[name! + " (Red)"]![0] += 1
        }
    }

    @objc func shotsCaughtBlue(sender: UIButton!) {
        let name = bgkb.titleLabel?.text!
        if goalieStats[name! + " (Blue)"] == nil {
            goalieStats[name! + " (Blue)"] = [0, 1, 0]
        } else {
            goalieStats[name! + " (Blue)"]![1] += 1
        }
    }

    @objc func shotsCaughtRed(sender: UIButton!) {
        let name = rgkb.titleLabel?.text!
        if goalieStats[name! + " (Red)"] == nil {
            goalieStats[name! + " (Red)"] = [0, 1, 0]
        } else {
            goalieStats[name! + " (Red)"]![1] += 1
        }
    }

    @objc func shotsBlockedBlue(sender: UIButton!) {
        let name = bgkb.titleLabel?.text!
        if goalieStats[name! + " (Blue)"] == nil {
            goalieStats[name! + " (Blue)"] = [0, 0, 1]
        } else {
            goalieStats[name! + " (Blue)"]![2] += 1
        }
    }

    @objc func shotsBlockedRed(sender: UIButton!) {
        let name = rgkb.titleLabel?.text!
        if goalieStats[name! + " (Red)"] == nil {
            goalieStats[name! + " (Red)"] = [0, 0, 1]
        } else {
            goalieStats[name! + " (Red)"]![2] += 1
        }
    }

    @objc func shotsAttemptedRWBlue(sender: UIButton!) {
        let name = brwb.titleLabel?.text!
        if playerStats[name! + " (Blue)"] == nil {
            playerStats[name! + " (Blue)"] = [1, 0, 0]
        } else {
            playerStats[name! + " (Blue)"]![0] += 1
        }
    }

    @objc func shotsAttemptedRWRed(sender: UIButton!) {
        let name = rrwb.titleLabel?.text!
        if playerStats[name! + " (Red)"] == nil {
            playerStats[name! + " (Red)"] = [1, 0, 0]
        } else {
            playerStats[name! + " (Red)"]![0] += 1
        }
    }

    @objc func shotsScoredRWBlue(sender: UIButton!) {
        let name = brwb.titleLabel?.text!
        if playerStats[name! + " (Blue)"] == nil {
            playerStats[name! + " (Blue)"] = [0, 1, 0]
        } else {
            playerStats[name! + " (Blue)"]![1] += 1
        }
        teamOneScore += 1
        title = "\(teamOneScore):\(teamTwoScore)"
    }

    @objc func shotsScoredRWRed(sender: UIButton!) {
        let name = rrwb.titleLabel?.text!
        if playerStats[name! + " (Red)"] == nil {
            playerStats[name! + " (Red)"] = [0, 1, 0]
        } else {
            playerStats[name! + " (Red)"]![1] += 1
        }
        teamTwoScore += 1
        title = "\(teamOneScore):\(teamTwoScore)"
    }

    @objc func passesInterceptedRWBlue(sender: UIButton!) {
        let name = brwb.titleLabel?.text!
        if playerStats[name! + " (Blue)"] == nil {
            playerStats[name! + " (Blue)"] = [0, 0, 1]
        } else {
            playerStats[name! + " (Blue)"]![2] += 1
        }
    }

    @objc func passesInterceptedRWRed(sender: UIButton!) {
        let name = rrwb.titleLabel?.text!
        if playerStats[name! + " (Red)"] == nil {
            playerStats[name! + " (Red)"] = [0, 0, 1]
        } else {
            playerStats[name! + " (Red)"]![2] += 1
        }
    }

    @objc func shotsAttemptedLWBlue(sender: UIButton!) {
        let name = blwb.titleLabel?.text!
        if playerStats[name! + " (Blue)"] == nil {
            playerStats[name! + " (Blue)"] = [1, 0, 0]
        } else {
            playerStats[name! + " (Blue)"]![0] += 1
        }
    }

    @objc func shotsAttemptedLWRed(sender: UIButton!) {
        let name = rlwb.titleLabel?.text!
        if playerStats[name! + " (Red)"] == nil {
            playerStats[name! + " (Red)"] = [1, 0, 0]
        } else {
            playerStats[name! + " (Red)"]![0] += 1
        }
    }

    @objc func shotsScoredLWBlue(sender: UIButton!) {
        let name = blwb.titleLabel?.text!
        if playerStats[name! + " (Blue)"] == nil {
            playerStats[name! + " (Blue)"] = [0, 1, 0]
        } else {
            playerStats[name! + " (Blue)"]![1] += 1
        }
        teamOneScore += 1
        title = "\(teamOneScore):\(teamTwoScore)"
    }

    @objc func shotsScoredLWRed(sender: UIButton!) {
        let name = rlwb.titleLabel?.text!
        if playerStats[name! + " (Red)"] == nil {
            playerStats[name! + " (Red)"] = [0, 1, 0]
        } else {
            playerStats[name! + " (Red)"]![1] += 1
        }
        teamTwoScore += 1
        title = "\(teamOneScore):\(teamTwoScore)"
    }

    @objc func passesInterceptedLWBlue(sender: UIButton!) {
        let name = blwb.titleLabel?.text!
        if playerStats[name! + " (Blue)"] == nil {
            playerStats[name! + " (Blue)"] = [0, 0, 1]
        } else {
            playerStats[name! + " (Blue)"]![2] += 1
        }
    }

    @objc func passesInterceptedLWRed(sender: UIButton!) {
        let name = rlwb.titleLabel?.text!
        if playerStats[name! + " (Red)"] == nil {
            playerStats[name! + " (Red)"] = [0, 0, 1]
        } else {
            playerStats[name! + " (Red)"]![2] += 1
        }
    }

    @objc func shotsAttemptedRFBlue(sender: UIButton!) {
        let name = brfb.titleLabel?.text!
        if playerStats[name! + " (Blue)"] == nil {
            playerStats[name! + " (Blue)"] = [1, 0, 0]
        } else {
            playerStats[name! + " (Blue)"]![0] += 1
        }
    }

    @objc func shotsAttemptedRFRed(sender: UIButton!) {
        let name = rrfb.titleLabel?.text!
        if playerStats[name! + " (Red)"] == nil {
            playerStats[name! + " (Red)"] = [1, 0, 0]
        } else {
            playerStats[name! + " (Red)"]![0] += 1
        }
    }

    @objc func shotsScoredRFBlue(sender: UIButton!) {
        let name = brfb.titleLabel?.text!
        if playerStats[name! + " (Blue)"] == nil {
            playerStats[name! + " (Blue)"] = [0, 1, 0]
        } else {
            playerStats[name! + " (Blue)"]![1] += 1
        }
        teamOneScore += 1
        title = "\(teamOneScore):\(teamTwoScore)"
    }

    @objc func shotsScoredRFRed(sender: UIButton!) {
        let name = rrfb.titleLabel?.text!
        if playerStats[name! + " (Red)"] == nil {
            playerStats[name! + " (Red)"] = [0, 1, 0]
        } else {
            playerStats[name! + " (Red)"]![1] += 1
        }
        teamTwoScore += 1
        title = "\(teamOneScore):\(teamTwoScore)"
    }

    @objc func passesInterceptedRFBlue(sender: UIButton!) {
        let name = brfb.titleLabel?.text!
        if playerStats[name! + " (Blue)"] == nil {
            playerStats[name! + " (Blue)"] = [0, 0, 1]
        } else {
            playerStats[name! + " (Blue)"]![2] += 1
        }
    }

    @objc func passesInterceptedRFRed(sender: UIButton!) {
        let name = rrfb.titleLabel?.text!
        if playerStats[name! + " (Red)"] == nil {
            playerStats[name! + " (Red)"] = [0, 0, 1]
        } else {
            playerStats[name! + " (Red)"]![2] += 1
        }
    }

    @objc func shotsAttemptedLFBlue(sender: UIButton!) {
        let name = blfb.titleLabel?.text!
        if playerStats[name! + " (Blue)"] == nil {
            playerStats[name! + " (Blue)"] = [1, 0, 0]
        } else {
            playerStats[name! + " (Blue)"]![0] += 1
        }
    }

    @objc func shotsAttemptedLFRed(sender: UIButton!) {
        let name = rlfb.titleLabel?.text!
        if playerStats[name! + " (Red)"] == nil {
            playerStats[name! + " (Red)"] = [1, 0, 0]
        } else {
            playerStats[name! + " (Red)"]![0] += 1
        }
    }

    @objc func shotsScoredLFBlue(sender: UIButton!) {
        let name = blfb.titleLabel?.text!
        if playerStats[name! + " (Blue)"] == nil {
            playerStats[name! + " (Blue)"] = [0, 1, 0]
        } else {
            playerStats[name! + " (Blue)"]![1] += 1
        }
        teamOneScore += 1
        title = "\(teamOneScore):\(teamTwoScore)"
    }

    @objc func shotsScoredLFRed(sender: UIButton!) {
        let name = rlfb.titleLabel?.text!
        if playerStats[name! + " (Red)"] == nil {
            playerStats[name! + " (Red)"] = [0, 1, 0]
        } else {
            playerStats[name! + " (Red)"]![1] += 1
        }
        teamTwoScore += 1
        title = "\(teamOneScore):\(teamTwoScore)"
    }

    @objc func passesInterceptedLFBlue(sender: UIButton!) {
        let name = blfb.titleLabel?.text!
        if playerStats[name! + " (Blue)"] == nil {
            playerStats[name! + " (Blue)"] = [0, 0, 1]
        } else {
            playerStats[name! + " (Blue)"]![2] += 1
        }
    }

    @objc func passesInterceptedLFRed(sender: UIButton!) {
        let name = rlfb.titleLabel?.text!
        if playerStats[name! + " (Red)"] == nil {
            playerStats[name! + " (Red)"] = [0, 0, 1]
        } else {
            playerStats[name! + " (Red)"]![2] += 1
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

    @IBAction func goalkeeper(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            // blue
            guard !gkBShow else {
                return
            }

            viewBGK.isHidden = false
            viewRGK.isHidden = true
            viewBRW.isHidden = true
            viewRRW.isHidden = true
            viewBLW.isHidden = true
            viewRLW.isHidden = true
            viewBRF.isHidden = true
            viewRRF.isHidden = true
            viewBLF.isHidden = true
            viewRLF.isHidden = true

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
            viewBRW.isHidden = true
            viewRRW.isHidden = true
            viewBLW.isHidden = true
            viewRLW.isHidden = true
            viewBRF.isHidden = true
            viewRRF.isHidden = true
            viewBLF.isHidden = true
            viewRLF.isHidden = true

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
            // blue right
            guard !rwBShow else {
                return
            }

            viewBGK.isHidden = true
            viewRGK.isHidden = true
            viewBRW.isHidden = false
            viewRRW.isHidden = true
            viewBLW.isHidden = true
            viewRLW.isHidden = true
            viewBRF.isHidden = true
            viewRRF.isHidden = true
            viewBLF.isHidden = true
            viewRLF.isHidden = true

            gkBShow = false
            gkRShow = false
            rwBShow = true
            rwRShow = false
            lwBShow = false
            lwRShow = false
            rfBShow = false
            rfRShow = false
            lfBShow = false
            lfRShow = false

            return
        case 1:
            // red right
            guard !rwRShow else {
                return
            }

            viewBGK.isHidden = true
            viewRGK.isHidden = true
            viewBRW.isHidden = true
            viewRRW.isHidden = false
            viewBLW.isHidden = true
            viewRLW.isHidden = true
            viewBRF.isHidden = true
            viewRRF.isHidden = true
            viewBLF.isHidden = true
            viewRLF.isHidden = true

            gkBShow = false
            gkRShow = false
            rwBShow = false
            rwRShow = true
            lwBShow = false
            lwRShow = false
            rfBShow = false
            rfRShow = false
            lfBShow = false
            lfRShow = false

            return
        case 2:
            // blue left
            guard !lwBShow else {
                return
            }

            viewBGK.isHidden = true
            viewRGK.isHidden = true
            viewBRW.isHidden = true
            viewRRW.isHidden = true
            viewBLW.isHidden = false
            viewRLW.isHidden = true
            viewBRF.isHidden = true
            viewRRF.isHidden = true
            viewBLF.isHidden = true
            viewRLF.isHidden = true

            gkBShow = false
            gkRShow = false
            rwBShow = false
            rwRShow = false
            lwBShow = true
            lwRShow = false
            rfBShow = false
            rfRShow = false
            lfBShow = false
            lfRShow = false

            return
        default:
            // red left
            guard !lwRShow else {
                return
            }

            viewBGK.isHidden = true
            viewRGK.isHidden = true
            viewBRW.isHidden = true
            viewRRW.isHidden = true
            viewBLW.isHidden = true
            viewRLW.isHidden = false
            viewBRF.isHidden = true
            viewRRF.isHidden = true
            viewBLF.isHidden = true
            viewRLF.isHidden = true

            gkBShow = false
            gkRShow = false
            rwBShow = false
            rwRShow = false
            lwBShow = false
            lwRShow = true
            rfBShow = false
            rfRShow = false
            lfBShow = false
            lfRShow = false

            return
        }
    }

    @IBAction func fullback(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            // blue right
            guard !rfBShow else {
                return
            }

            viewBGK.isHidden = true
            viewRGK.isHidden = true
            viewBRW.isHidden = true
            viewRRW.isHidden = true
            viewBLW.isHidden = true
            viewRLW.isHidden = true
            viewBRF.isHidden = false
            viewRRF.isHidden = true
            viewBLF.isHidden = true
            viewRLF.isHidden = true

            gkBShow = false
            gkRShow = false
            rwBShow = false
            rwRShow = false
            lwBShow = false
            lwRShow = false
            rfBShow = true
            rfRShow = false
            lfBShow = false
            lfRShow = false

            return
        case 1:
            // red right
            guard !rfRShow else {
                return
            }

            viewBGK.isHidden = true
            viewRGK.isHidden = true
            viewBRW.isHidden = true
            viewRRW.isHidden = true
            viewBLW.isHidden = true
            viewRLW.isHidden = true
            viewBRF.isHidden = true
            viewRRF.isHidden = false
            viewBLF.isHidden = true
            viewRLF.isHidden = true

            gkBShow = false
            gkRShow = false
            rwBShow = false
            rwRShow = false
            lwBShow = false
            lwRShow = false
            rfBShow = false
            rfRShow = true
            lfBShow = false
            lfRShow = false

            return
        case 2:
            // blue left
            guard !lfBShow else {
                return
            }

            viewBGK.isHidden = true
            viewRGK.isHidden = true
            viewBRW.isHidden = true
            viewRRW.isHidden = true
            viewBLW.isHidden = true
            viewRLW.isHidden = true
            viewBRF.isHidden = true
            viewRRF.isHidden = true
            viewBLF.isHidden = false
            viewRLF.isHidden = true

            gkBShow = false
            gkRShow = false
            rwBShow = false
            rwRShow = false
            lwBShow = false
            lwRShow = false
            rfBShow = false
            rfRShow = false
            lfBShow = true
            lfRShow = false

            return
        default:
            // red left
            guard !lfRShow else {
                return
            }

            viewBGK.isHidden = true
            viewRGK.isHidden = true
            viewBRW.isHidden = true
            viewRRW.isHidden = true
            viewBLW.isHidden = true
            viewRLW.isHidden = true
            viewBRF.isHidden = true
            viewRRF.isHidden = true
            viewBLF.isHidden = true
            viewRLF.isHidden = false

            gkBShow = false
            gkRShow = false
            rwBShow = false
            rwRShow = false
            lwBShow = false
            lwRShow = false
            rfBShow = false
            rfRShow = false
            lfBShow = false
            lfRShow = true

            return
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ResultsVC {
            vc.teamOneScore = teamOneScore
            vc.teamTwoScore = teamTwoScore
            vc.goalieStats = goalieStats
            vc.playerStats = playerStats
            vc.teamOneName = teamOneName
            vc.teamTwoName = teamTwoName
        }
    }
}

enum Positions {
    case GOALKEEPER
    case LEFT_WINGER
    case RIGHT_WINGER
    case LEFT_FULLBACK
    case RIGHT_FULLBACK
    
    func toShort() -> String {
        switch(self) {
        case .GOALKEEPER:
            return "GK"
        case .LEFT_WINGER:
            return "LW"
        case .RIGHT_WINGER:
            return "RW"
        case .LEFT_FULLBACK:
            return "LF"
        case .RIGHT_FULLBACK:
            return "RF"
        }
    }
}

enum Possesion {
    case NONE
    case BLUE
    case RED
}
