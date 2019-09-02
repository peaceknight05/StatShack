//
//  ViewController.swift
//  StatShack
//
//  Created by Santhiyaa Senthilkumar and Jonathan Tan Jiayi on 7/5/19.
//  Copyright © 2019 Santhiyaa Senthilkumar and Jonathan Tan Jiayi. All rights reserved.
//

import CoreData
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        navigationItem.title = "Home"
    }
    
    @IBAction func deleteAll(_ sender: UIButton) {
        deleteAllData("Entry")
    }
    
    func deleteAllData(_ entity: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(batchDeleteRequest)
        } catch let error as NSError {
            print("Could not execute. \(error), \(error.userInfo)")
        }
    }
}
