//
//  ViewController.swift
//  Bucket List
//
//  Created by Olivier Butler on 12/09/2017.
//  Copyright © 2017 Olivier Butler. All rights reserved.
//

import UIKit

class BucketController: UITableViewController, AddViewControllerDelegate {
    
    
    @IBOutlet var bucketTableView: UITableView!
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toGetDone.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath)
        cell.textLabel?.text = toGetDone[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        toGetDone.remove(at: indexPath.row)
        bucketTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "editPressedSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let addViewController = navController.topViewController as! AddViewController
        addViewController.delegate = self
        if segue.identifier == "editPressedSegue" {
            let outgoingIndex = sender! as! IndexPath
            addViewController.view!.backgroundColor = UIColor.orange
            addViewController.incomingIndexPath = outgoingIndex
            addViewController.incomingText = toGetDone[outgoingIndex.row]
        }
    }
    
    func cancelButtonPressed(by controller: AddViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveButtonPressed(by controller: AddViewController, with: String, replaceRowAtIndex: IndexPath?) {
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

