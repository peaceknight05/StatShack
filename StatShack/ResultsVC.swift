//
//  ResultsVC.swift
//  StatShack
//
//  Created by Jonathan Tan on 3/9/19.
//  Copyright © 2019 Santhiyaa Senthilkumar. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController {
    var teamOneScore = 0
    var teamTwoScore = 0
    var teamOneName: String?
    var teamTwoName: String?
    var goalieStats: [String: [Int]] = [:]
    var playerStats: [String: [Int]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Stats for \(teamOneName ?? "Team One") vs \(teamTwoName ?? "Team Two")"

        print(goalieStats)
        print(playerStats)
    }
}
