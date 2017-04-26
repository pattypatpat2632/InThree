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
        self.navigationController?.navigationBar.isHidden = false
        self.view = createUserView
        createUserView.submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }

    func submitTapped() {
        print("Submit tapped")
        guard allFieldsEntered() else {return}
        print("All fields entered")
        guard let email = createUserView.emailField.text, let name = createUserView.nameField.text, let password = createUserView.passwordField.text, let confirm = createUserView.confirmField.text else {return} //TODO: this error should never occur since we're already checking for empty fields in the allFieldsEntered function. Refactor
        guard password == confirm else {return} //TODO: indicate to the user that the password and confirm fields do not match
        print("passwords match, creating user")
        FirebaseManager.sharedInstance.createUser(fromEmail: email, name: name, andPassword: password) { (firResponse) in
            print("create user responded")
            switch firResponse {
            case .success(let successString):
                print(successString)
                let sequencerVC = SequencerVC()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(sequencerVC, animated: true) //TODO: change this to push to the dashboard VC once that's working
                }
            case .failure(let failString):
                print(failString)
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
