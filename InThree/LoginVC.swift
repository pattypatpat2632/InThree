//
//  LoginVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.


import UIKit

class LoginVC: UIViewController, UserAlert {
    
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
        loginView.forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
    }
    
    func createUserTapped() {
        loginView.indicateSelected(view: loginView.createUserButton) {
            let createUserVC = CreateUserVC()
            self.navigationController?.pushViewController(createUserVC, animated: true)
        }
    }
    
    func loginTapped() {
        if loginView.emailField.text == "" {
            loginView.indicateRequired(fieldView: loginView.emailField)
            return
        } else if loginView.passwordField.text == "" {
            loginView.indicateRequired(fieldView: loginView.passwordField)
            return
        } else {
            loginView.indicateSelected(view: loginView.loginButton) {
                guard let email = self.loginView.emailField.text, let password = self.loginView.passwordField.text else {return}
                FirebaseManager.sharedInstance.loginUser(fromEmail: email, password: password, completion: { (firResponse) in
                    switch firResponse {
                    case .success(let successString):
                        print(successString)
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                        }
                    case .failure(let failString):
                        self.alertUser(with: failString, viewController: self, completion: nil)
                    }
                })
            }
        }
    }
    
    func forgotPasswordTapped() {
        print("Forgot password")
        self.loginView.indicatePushed(view: loginView.forgotPasswordButton) {
            let resetVC = ForgotPasswordVC()
            self.navigationController?.pushViewController(resetVC, animated: true)
        }
    }
}
