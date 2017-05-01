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
        self.hideKeyboardWhenTappedAround()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func addTargets() {
        loginView.createUserButton.addTarget(self, action: #selector(createUserTapped), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    func createUserTapped() {
        let createUserVC = CreateUserVC()
        self.navigationController?.pushViewController(createUserVC, animated: true)
    }
    
    func loginTapped() {
        if loginView.emailField.text == "" {
            loginView.indicateRequired(fieldView: loginView.emailField)
            return
        } else if loginView.passwordField.text == "" {
            loginView.indicateRequired(fieldView: loginView.passwordField)
            return
        } else {
            guard let email = loginView.emailField.text, let password = loginView.passwordField.text else {return} //TODO: handle this better
            LoginManager.sharedInstance.loginUser(fromEmail: email, password: password, completion: { (firResponse) in
                switch firResponse {
                case .success(let successString):
                    print(successString)
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                    }
                case .failure(let failString):
                    print(failString)
                }
            })
        }
        
        
    }
    
}
