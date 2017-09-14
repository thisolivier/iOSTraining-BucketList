//
//  AddViewControllerDelegate.swift
//  Bucket List
//
//  Created by Olivier Butler on 12/09/2017.
//  Copyright © 2017 Olivier Butler. All rights reserved.
//

import Foundation

protocol AddViewControllerDelegate: class{
    func saveButtonPressed(by controller: AddViewController, with: String, replaceRowAtIndex: IndexPath?)
    func cancelButtonPressed(by controller: AddViewController)
}
