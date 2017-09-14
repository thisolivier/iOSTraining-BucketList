//
//  ViewController.swift
//  Bucket List
//
//  Created by Olivier Butler on 12/09/2017.
//  Copyright © 2017 Olivier Butler. All rights reserved.
//

import UIKit

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
    
    // Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        toGetDone.remove(at: indexPath.row)
        bucketTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    // Edit
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToNewAndEdit", sender: indexPath)
    }
    
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

