//
//  HandBallPlayerEditVC.swift
//  StatShack
//
//  Created by Jonathan Tan on 29/5/19.
//  Copyright © 2019 Santhiyaa Senthilkumar. All rights reserved.
//

import UIKit

class HandBallPlayerEditVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: var

    @IBOutlet var teamOneTable: UITableView!
    @IBOutlet var teamTwoTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamOneTable.delegate = self
        teamTwoTable.delegate = self
        teamOneTable.dataSource = self
        teamTwoTable.dataSource = self
        teamOneTable.tag = 0
        teamTwoTable.tag = 1
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    // 0 means blue 1 means red

    // MARK: Data Source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 4
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamOneCell", for: indexPath)
            cell.textLabel?.text = "Player \(indexPath.row + 1)"
            cell.textLabel?.isEnabled = true
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTwoCell", for: indexPath)
            cell.textLabel?.text = "Player \(indexPath.row + 1)"
            cell.textLabel?.isEnabled = true
            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Goalkeeper"
        } else {
            return "Player"
        }
    }
    
}
