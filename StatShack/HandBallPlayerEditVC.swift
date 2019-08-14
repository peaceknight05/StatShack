//
//  HandBallPlayerEditVC.swift
//  StatShack
//
//  Created by Jonathan Tan on 29/5/19.
//  Copyright © 2019 Santhiyaa Senthilkumar. All rights reserved.
//

import UIKit
import FDTextFieldTableViewCell

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
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamOneCell", for: indexPath) as! FDTextFieldTableViewCell
            if (indexPath.section == 0) {
                cell.textLabel?.text = "Goalkeeper"
            } else {
                switch (indexPath.row) {
                case 0:
                    cell.textLabel?.text = "Left Winger"
                case 1:
                    cell.textLabel?.text = "Right Winger"
                case 2:
                    cell.textLabel?.text = "Left Fullback"
                case 3:
                    cell.textLabel?.text = "Right Fullback"
                default:
                    cell.textLabel?.text = "Subsitute  \(indexPath.row - 3)"
                }
            }
            cell.textField.text = "Name"
            cell.textLabel?.isEnabled = true
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTwoCell", for: indexPath) as! FDTextFieldTableViewCell
            if (indexPath.section == 0) {
                cell.textLabel?.text = "Goalkeeper"
            } else {
                switch (indexPath.row) {
                case 0:
                    cell.textLabel?.text = "Left Winger"
                case 1:
                    cell.textLabel?.text = "Right Winger"
                case 2:
                    cell.textLabel?.text = "Left Fullback"
                case 3:
                    cell.textLabel?.text = "Right Fullback"
                default:
                    cell.textLabel?.text = "Subsitute  \(indexPath.row - 3)"
                }
            }
            cell.textField.text = "Name"
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
    
    @IBAction func teamOneEdit(_ sender: UIButton) {
        if (!teamOneTable.isEditing) {
            teamOneTable.setEditing(true, animated: true)
        } else {
            teamOneTable.setEditing(false, animated: true)
        }
    }
    
    @IBAction func teamTwoEdit(_ sender: UIButton) {
        if (!teamTwoTable.isEditing) {
            teamTwoTable.setEditing(true, animated: true)
        } else {
            teamTwoTable.setEditing(false, animated: true)
        }
    }
}
