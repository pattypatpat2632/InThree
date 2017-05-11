//
//  ForgotPasswordView.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ForgotPasswordView: UIView, BlipBloopView {

    let titleLabel = BlipLabel()
    let emailField = BlipTextField()
    let passwordField = BlipTextField()
    let confirmField = BlipTextField()
    let submitButton = BlipButton()
    var delegate: ForgotPasswordFieldDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = colorScheme.model.baseColor
        setConstraints()
        setSubviewProperties()
    }
    
    func setConstraints() {
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        
        addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        emailField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emailField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        emailField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
        
        addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 5).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passwordField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        passwordField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
        
        addSubview(confirmField)
        confirmField.translatesAutoresizingMaskIntoConstraints = false
        confirmField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 5).isActive = true
        confirmField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        confirmField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        confirmField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
        
        addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.topAnchor.constraint(equalTo: confirmField.bottomAnchor, constant: 5).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        submitButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
    }
    
    func setSubviewProperties() {
        titleLabel.text = "Reset Password"
        titleLabel.changeFontSize(to: 24)
        
        emailField.placeholder = "Email"
        
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        
        confirmField.placeholder = "Confirm Password"
        confirmField.isSecureTextEntry = true
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
    }
    
    func submitTapped() {
        self.indicateSelected(view: submitButton) { 
            self.delegate?.submit()
        }
    }

}

protocol ForgotPasswordFieldDelegate {
    func submit()
}
