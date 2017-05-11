//
//  CreditsVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/11/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class CreditsVC: UIViewController {
    
    let creditsView = CreditsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = creditsView
        navigationController?.navigationBar.isHidden = false
    }

}
