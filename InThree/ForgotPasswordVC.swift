//
//  ForgotPasswordVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController, ForgotPasswordViewDelegate, UserAlert {
    
    let forgotPasswordView = ForgotPasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = forgotPasswordView
        forgotPasswordView.delegate = self
    }
    
    func submit() {
        guard emailEntered() else {return}
        forgotPasswordView.indicateSelected(view: forgotPasswordView.submitButton) {
            guard let email = self.forgotPasswordView.emailField.text else {return} //TODO: this error should never occur since we're already checking for empty fields in the allFieldsEntered function. Refactor
            
            FirebaseManager.sharedInstance.resetPassword(from: email, completion: { (response) in
                switch response {
                case .success(let successString):
                    print(successString)
                    self.alertUser(with: "Password reset sent to your email address", viewController: self, completion: {
                        self.navigationController?.popViewController(animated: true)
                    })
                case .failure(let failString):
                    print(failString)
                    self.alertUser(with: "Could not reset password", viewController: self, completion: nil)
                }
            })
        }
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func emailEntered() -> Bool{
        if forgotPasswordView.emailField.text == "" || forgotPasswordView.emailField.text == nil {
            forgotPasswordView.indicateRequired(fieldView: forgotPasswordView.emailField)
            return false
        }
        return true
    }
}
