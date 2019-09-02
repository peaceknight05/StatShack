//
//  ResultsVC.swift
//  StatShack
//
//  Created by Jonathan Tan on 3/9/19.
//  Copyright © 2019 Santhiyaa Senthilkumar. All rights reserved.
//

import UIKit
import CoreData

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
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        save(teamOneName ?? "Team One", teamTwoName ?? "Team Two", Int16(teamOneScore), Int16(teamTwoScore))
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
