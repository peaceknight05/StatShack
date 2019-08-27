//
//  HandBallPlayerEditVC.swift
//  StatShack
//
//  Created by Jonathan Tan on 29/5/19.
//  Copyright © 2019 Santhiyaa Senthilkumar. All rights reserved.
//

import FDTextFieldTableViewCell
import UIKit

class HandBallPlayerEditVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: var

    @IBOutlet var teamOneTable: UITableView!
    @IBOutlet var teamTwoTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableSetup()

        teamOneTable.dataSource = self
        teamOneTable.delegate   = self
        teamOneTable.tag        = 0
        teamTwoTable.dataSource = self
        teamTwoTable.delegate   = self
        teamTwoTable.tag        = 1

        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0 {
            var cell: FDTextFieldTableViewCell?
            cell = (tableView.dequeueReusableCell(withIdentifier: "TeamOneCell") as! FDTextFieldTableViewCell)
            guard cell != nil else {
                print("dequeued cell is nil")
                abort()
            }

            if indexPath.section == 0 {
                cell?.textLabel?.text = "Goalkeeper"
            } else {
                switch indexPath.row {
                case 0:
                    cell?.textLabel?.text = "Left Winger"
                case 1:
                    cell?.textLabel?.text = "Right Winger"
                case 2:
                    cell?.textLabel?.text = "Left Fullback"
                case 3:
                    cell?.textLabel?.text = "Right Fullback"
                default:
                    cell?.textLabel?.text = "Subsitute  \(indexPath.row - 3)"
                }
            }
            cell?.textField.text = "Name"
            cell?.textLabel?.isEnabled = true
            cell?.backgroundColor = UIColor(red: 100, green: 199, blue: 229, alpha: 1)

            return cell!
        } else {
            var cell: FDTextFieldTableViewCell?
            cell = (tableView.dequeueReusableCell(withIdentifier: "TeamTwoCell", for: indexPath) as! FDTextFieldTableViewCell)
            guard cell != nil else {
                print("dequeued cell is nil")
                abort()
            }

            if indexPath.section == 0 {
                cell?.textLabel?.text = "Goalkeeper"
            } else {
                switch indexPath.row {
                case 0:
                    cell?.textLabel?.text = "Left Winger"
                case 1:
                    cell?.textLabel?.text = "Right Winger"
                case 2:
                    cell?.textLabel?.text = "Left Fullback"
                case 3:
                    cell?.textLabel?.text = "Right Fullback"
                default:
                    cell?.textLabel?.text = "Subsitute  \(indexPath.row - 3)"
                }
            }
            cell?.textField.text = "Name"
            cell?.textLabel?.isEnabled = true
            return cell!
        }
    }
}

extension HandBallPlayerEditVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 4
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Goalkeeper"
        } else {
            return "Player"
        }
    }
}

extension HandBallPlayerEditVC {
    func tableSetup() {
        teamOneTable.register(FDTextFieldTableViewCell.self, forCellReuseIdentifier: "TeamOneCell")
        teamTwoTable.register(FDTextFieldTableViewCell.self, forCellReuseIdentifier: "TeamTwoCell")
    }
}
