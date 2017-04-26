//
//  LoginVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        addTargets()
    }
    
    func addTargets() {
        loginView.createUserButton.addTarget(self, action: #selector(createUserTapped), for: .touchUpInside)
    }
    
    func createUserTapped() {
        let createUserVC = CreateUserVC()
        self.navigationController?.pushViewController(createUserVC, animated: true)
    }
    
}
