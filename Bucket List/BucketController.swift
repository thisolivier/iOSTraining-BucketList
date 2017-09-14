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
    var toGetDone = [BucketListItem]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var bucketTableView: UITableView!
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "segueToNewAndEdit", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toGetDone.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath)
        cell.textLabel?.text = toGetDone[indexPath.row].listItemText
        return cell
    }
    
    // Fetch permenantly stored items
    func fetchAllItems(){
        // NextStep object specifies type in triangular brackets
        let itemsRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            let itemsResult = try managedObjectContext.fetch(itemsRequest)
            toGetDone.append(contentsOf: itemsResult as! [BucketListItem])
        } catch {
            print("Failed to load data")
        }
    }
    
    // Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        managedObjectContext.delete(toGetDone[indexPath.row])
        do {
            try managedObjectContext.save()
        } catch {
            print("--------------")
            print("Failed to save")
            print("\(error)")
        }
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
                addEditViewContInstance.incomingText = toGetDone[senderIndexPath.row].listItemText
                addEditViewContInstance.view!.backgroundColor = UIColor.orange
            }
        }
    }
    
    // Add&Edit protocol methods
    func cancelButtonPressed(by controller: AddEditViewController) {
        dismiss(animated: true, completion: nil)
    }
    func saveButtonPressed(by controller: AddEditViewController, with: String, replaceRowAtIndex: IndexPath?) {
        if let _ = replaceRowAtIndex {
            print ("Updating an item")
            toGetDone[replaceRowAtIndex!.row].listItemText = with
        } else {
            print ("""
                We are trying to save
            """)
            let newItem = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            newItem.listItemText = with
            toGetDone.append(newItem)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Could not save: \(error)")
        }
        
        bucketTableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

