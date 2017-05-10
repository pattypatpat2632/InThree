//
//  CreateUserView.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class CreateUserView: UIView, BlipBloopView {
    
    let colorScheme: ColorScheme = .normal
    let titleLabel = UILabel()
    let nameField = UITextField()
    let emailField = UITextField()
    let passwordField = UITextField()
    let confirmField = UITextField()
    let submitButton = BlipButton()
    var allFields = [UITextField]()
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        setConstraints()
        setSubviewProperties()
        allFields = [nameField, emailField, passwordField, confirmField]
    }
    
    func setConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        
        addSubview(nameField)
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        nameField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        nameField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
        
        addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10).isActive = true
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
        submitButton.topAnchor.constraint(equalTo: confirmField.bottomAnchor, constant: 10).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        submitButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
    }
    
    func setSubviewProperties() {
        self.backgroundColor = colorScheme.model.baseColor
        
        titleLabel.text = "Create New User"
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = colorScheme.model.foregroundColor
        
        nameField.placeholder = "Your Name"
        nameField.backgroundColor = colorScheme.model.backgroundColor
        nameField.layer.cornerRadius = 5
        nameField.layer.borderWidth = 2
        nameField.layer.borderColor = colorScheme.model.highlightColor.cgColor
        
        emailField.placeholder = "Email"
        emailField.backgroundColor = colorScheme.model.backgroundColor
        emailField.layer.cornerRadius = 5
        emailField.layer.borderWidth = 2
        emailField.layer.borderColor = colorScheme.model.highlightColor.cgColor
        
        passwordField.placeholder = "Password"
        passwordField.backgroundColor = colorScheme.model.backgroundColor
        passwordField.layer.cornerRadius = 5
        passwordField.layer.borderWidth = 2
        passwordField.layer.borderColor = colorScheme.model.highlightColor.cgColor
        passwordField.isSecureTextEntry = true
        
        confirmField.placeholder = "Confirm Password"
        confirmField.backgroundColor = colorScheme.model.backgroundColor
        confirmField.layer.cornerRadius = 5
        confirmField.layer.borderWidth = 2
        confirmField.layer.borderColor = colorScheme.model.highlightColor.cgColor
        confirmField.isSecureTextEntry = true
        
        submitButton.setTitle("Submit", for: .normal)
    }
    
}
