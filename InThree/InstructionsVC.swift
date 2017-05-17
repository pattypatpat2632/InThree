//
//  InstructionsVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/17/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class InstructionsVC: UIViewController {

    let instructionsView = InstructionsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = instructionsView
        navigationController?.navigationBar.isHidden = false
    }

}
