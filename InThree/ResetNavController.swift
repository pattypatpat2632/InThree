//
//  ResetNavController.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ResetNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = false
        self.setViewControllers([ForgotPasswordVC()], animated: false)
    }


}
