//
//  ViewController.swift
//  core-data-snippet
//
//  Created by Declan on 18/06/2019.
//  Copyright © 2019 Declan Conway. All rights reserved.
//

// Please note that Core Data was selected on project setup.

// Launch the app, tap the "Increase score" button, tap "Save Data" button,
// kill the app, relaunch the app and see the saved value being retrieved


import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    //Create a variable called score, give a type of Int and init to 0.
    var score: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Call getData() to display value already stored in core data.
        getData()
        
        //Set the score label to the score
        scoreLabel.text = String(score)
    }

    @IBAction func increaseScoreTapped(_ sender: Any) {
        //Increase the score when the "Increase Score" button is clicked.
        score = score + 1 //This can also be written as score += 1
        scoreLabel.text = String(score)
    }
    
    @IBAction func saveDataTapped(_ sender: Any) {
        //Save Data to the system
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
    
        newEntity.setValue(score, forKey: "number")
        
        do {
            try context.save()
            print("Saved")
            
        } catch {
            print("Failed Saving")
        }
    }
    
    func getData() {
        //Retrieve the data from Core Data
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                score = data.value(forKey: "number") as! Int
            }
        } catch {
            print("Failed")
        }
    }
    
}

