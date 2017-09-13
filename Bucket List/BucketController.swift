//
//  ViewController.swift
//  Bucket List
//
//  Created by Olivier Butler on 12/09/2017.
//  Copyright © 2017 Olivier Butler. All rights reserved.
//

import UIKit

class BucketController: UITableViewController {
    var toGetDone = [
        "Get motorcycling liscence",
        "Make a short film",
        "Write a collection of stories",
        "Get in a bar fight",
        "Stop an evil",
        "Build my own motorbike/car",
        "Find whoever built the swift syllabus, kill"
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

}

