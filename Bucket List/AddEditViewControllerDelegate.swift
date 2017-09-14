//
//  AddViewControllerDelegate.swift
//  Bucket List
//
//  Created by Olivier Butler on 12/09/2017.
//  Copyright © 2017 Olivier Butler. All rights reserved.
//

import Foundation

protocol AddEditViewControllerDelegate: class{
    func saveButtonPressed(by controller: AddEditViewController, with: String, replaceRowAtIndex: IndexPath?)
    func cancelButtonPressed(by controller: AddEditViewController)
}
