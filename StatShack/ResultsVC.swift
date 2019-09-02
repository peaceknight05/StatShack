//
//  ResultsVC.swift
//  StatShack
//
//  Created by Jonathan Tan on 3/9/19.
//  Copyright © 2019 Santhiyaa Senthilkumar. All rights reserved.
//

import CoreData
import UIKit

class ResultsVC: UITableViewController {
    var teamOneScore = 0
    var teamTwoScore = 0
    var teamOneName: String?
    var teamTwoName: String?
    var goalieStats: [String: [Int]] = [:]
    var playerStats: [String: [Int]] = [:]
    var totalGameTime: TimeInterval!
    var teamOnePossesion: TimeInterval!
    var teamTwoPossesion: TimeInterval!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Stats for \(teamOneName ?? "Team One") vs \(teamTwoName ?? "Team Two")"
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        save(teamOneName ?? "Team One", teamTwoName ?? "Team Two", Int16(teamOneScore), Int16(teamTwoScore))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Goalkeeper (Shots Let In/Shots Caught/Shots Blocked)"
        } else if section == 1 {
            return "Player (Shots Attempted/Shots Scored/Passes Intercepted)"
        } else {
            return "Possesion (%)"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2 {
            return 2
        } else {
            return 8
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if indexPath.section == 0 {
            let keys = Array(goalieStats.keys)
            cell?.textLabel?.text = keys[indexPath.row]
            cell?.detailTextLabel?.text = "\(goalieStats[keys[indexPath.row]]![0])/\(goalieStats[keys[indexPath.row]]![1])/\(goalieStats[keys[indexPath.row]]![2])"
        } else if indexPath.section == 1 {
            let keys = Array(playerStats.keys)
            cell?.textLabel?.text = keys[indexPath.row]
            cell?.detailTextLabel?.text = "\(playerStats[keys[indexPath.row]]![0])/\(playerStats[keys[indexPath.row]]![1])/\(playerStats[keys[indexPath.row]]![2])"
        } else {
            if indexPath.row == 0 {
                cell?.textLabel?.text = teamOneName ?? "Team One"
                cell?.detailTextLabel?.text = "\(Double(((teamOnePossesion / totalGameTime) * 1000).rounded()) / 10)%"
            } else {
                cell?.textLabel?.text = teamTwoName ?? "Team Two"
                cell?.detailTextLabel?.text = "\(Double(((teamTwoPossesion / totalGameTime) * 1000).rounded()) / 10)%"
            }
        }
        
        return cell!
    }

    func save(_ teamOneName: String, _ teamTwoName: String, _ teamOneScore: Int16, _ teamTwoScore: Int16) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext

        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Entry",
                                       in: managedContext)!
        let entry = NSManagedObject(entity: entity,
                                    insertInto: managedContext)

        // 3
        entry.setValue(teamOneName, forKeyPath: "teamOneName")
        entry.setValue(teamTwoName, forKeyPath: "teamTwoName")
        entry.setValue(teamOneScore, forKeyPath: "teamOneScore")
        entry.setValue(teamTwoScore, forKeyPath: "teamTwoScore")

        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
