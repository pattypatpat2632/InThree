//
//  CreateUserVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class CreateUserVC: UIViewController, UserAlert {
    
    let createUserView = CreateUserView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.view = createUserView
        self.hideKeyboardWhenTappedAround()
        createUserView.submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    func submitTapped() {
        guard allFieldsEntered() else {return}
        guard let email = createUserView.emailField.text, let name = createUserView.nameField.text, let password = createUserView.passwordField.text, let confirm = createUserView.confirmField.text else {return}
        guard password == confirm else {
            alertUser(with: "Password does not match confirmation", viewController: self, completion: {
            })
            return
        }
        createUserView.indicateSelected(view: createUserView.submitButton) {
            print("passwords match, creating user")
            FirebaseManager.sharedInstance.createUser(fromEmail: email, name: name, andPassword: password) { (firResponse) in
                print("create user responded")
                switch firResponse {
                case .success(let successString):
                    print(successString)
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                    }
                case .failure(let failString):
                    print(failString)
                }
            }
        }
    }
    
    func allFieldsEntered() -> Bool {
        var allFieldsEntered: Bool = true
        for field in createUserView.allFields {
            if field.text == "" {
                createUserView.indicateRequired(fieldView: field)
                allFieldsEntered = false
            }
        }
        return allFieldsEntered
    }
    
}
