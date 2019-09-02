//
//  PreviousStatsVC.swift
//  StatShack
//
//  Created by Santhiyaa Senthilkumar on 8/5/19.
//  Copyright © 2019 Santhiyaa Senthilkumar. All rights reserved.
//

import CoreData
import UIKit

class PreviousStatsVC: UITableViewController {
    // MARK: var

    @IBOutlet var dataView: UITableView!
    var entries: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        dataView.dataSource = self
        dataView.delegate = self
        navigationItem.title = "Previous Stats"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        // 2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Entry")

        // 3
        do {
            entries = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)

        cell.textLabel?.text = "\(entries[indexPath.row].value(forKeyPath: "teamOneName") as! String) vs \(entries[indexPath.row].value(forKeyPath: "teamTwoName") as! String)"
        
        cell.detailTextLabel?.text = "\(entries[indexPath.row].value(forKeyPath: "teamOneScore") as! Int):\(entries[indexPath.row].value(forKeyPath: "teamTwoScore") as! Int)"

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Results"
    }
}
