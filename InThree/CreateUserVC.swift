//
//  CreateUserVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class CreateUserVC: UIViewController {
    
    let createUserView = CreateUserView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = createUserView
    }



}
