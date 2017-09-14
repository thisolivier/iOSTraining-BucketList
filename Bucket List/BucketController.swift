//
//  ViewController.swift
//  Bucket List
//
//  Created by Olivier Butler on 12/09/2017.
//  Copyright © 2017 Olivier Butler. All rights reserved.
//

import UIKit
import CoreData

class BucketController: UITableViewController, AddEditViewControllerDelegate {
    var toGetDone = [
        "Get motorcycling liscence",
        "Make a short film",
        "Write a collection of stories",
        "Get in a bar fight",
        "Stop an evil",
        "Build my own motorbike/car",
        "See the tropical forest canopy from above at sunset",
        "Fly", 
        "Build a walking robot"
        ]
    let managedObject = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var bucketTableView: UITableView!
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "segueToNewAndEdit", sender: sender)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toGetDone.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath)
        cell.textLabel?.text = toGetDone[indexPath.row]
        return cell
    }
    
    // Fetch permenantly stored items
    func fetchAllItems(){
        // NextStep object specifies type in triangular brackets
        let itemsRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            let itemsResult = try managedObject.fetch(itemsRequest)
            let bucketListItem = itemsResult as! [String]
        } catch {
            print("Failed to load data")
        }
    }
    
    // Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        toGetDone.remove(at: indexPath.row)
        bucketTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    // Edit
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToNewAndEdit", sender: indexPath)
    }
    // Prepare for seg
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let addEditViewContInstance = navController.topViewController as! AddEditViewController
        addEditViewContInstance.delegate = self
        
        if let newSender = sender {
            let senderMirror = Mirror(reflecting: newSender)
            if senderMirror.subjectType == NSIndexPath.self {
                let senderIndexPath = newSender as! IndexPath
                addEditViewContInstance.incomingIndexPath = senderIndexPath
                addEditViewContInstance.incomingText = toGetDone[senderIndexPath.row]
                addEditViewContInstance.view!.backgroundColor = UIColor.orange
            }
        }
    }
    
    // Add&Edit protocol methods
    func cancelButtonPressed(by controller: AddEditViewController) {
        dismiss(animated: true, completion: nil)
    }
    func saveButtonPressed(by controller: AddEditViewController, with: String, replaceRowAtIndex: IndexPath?) {
        print("\(with)")
        if let _ = replaceRowAtIndex {
            toGetDone[replaceRowAtIndex!.row] = with
        } else {
            toGetDone.append(with)
        }
        bucketTableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

