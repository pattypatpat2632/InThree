//
//  ForgotPasswordVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    let forgotPasswordView = ForgotPasswordView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = forgotPasswordView
    }


}
