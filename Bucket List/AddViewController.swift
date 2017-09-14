 //
//  AddViewController.swift
//  Bucket List
//
//  Created by Olivier Butler on 12/09/2017.
//  Copyright © 2017 Olivier Butler. All rights reserved.
//

import UIKit

class AddViewController: UITableViewController {
    var delegate: AddViewControllerDelegate?
    var incomingText: String?
    var incomingIndexPath: IndexPath?
    
    @IBOutlet weak var newBucketlistItem: UITextField!
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let text = newBucketlistItem.text
        if let _ = text {
            if let _ = incomingIndexPath {
                delegate?.saveButtonPressed(by: self, with: text!, replaceRowAtIndex: incomingIndexPath!)
            } else {
                delegate?.saveButtonPressed(by: self, with: text!, replaceRowAtIndex: nil)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = incomingText{
            newBucketlistItem.text = incomingText!
        }
    }
}
