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
    var startTime: Date?
    var elapsedTime: TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    var teamOneNames: [Positions: String]?
    var teamTwoNames: [Positions: String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func startTimer() {
        startTime = Date()
    }
}

enum Positions {
    case GOALKEEPER
    case LEFT_WINGER
    case RIGHT_WINGER
    case LEFT_FULLBACK
    case RIGHT_FULLBACK
}
