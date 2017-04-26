//
//  LoginView.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class LoginView: UIView, BlipBloopView {
    
    let titleLabel = UILabel()
    let emailField = UITextField()
    let passwordField = UITextField()
    let loginButton = UIButton()
    let createUserButton = UIButton()

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
    }
    
    func setConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
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
        
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 5).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        loginButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        
        addSubview(createUserButton)
        createUserButton.translatesAutoresizingMaskIntoConstraints = false
        createUserButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        createUserButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        createUserButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        createUserButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
    }
    
    func setSubviewProperties() {
        self.backgroundColor = colorScheme.model.baseColor
        
        titleLabel.text = "BlipBloop"
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = colorScheme.model.foregroundColor
        
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
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(colorScheme.model.foregroundColor, for: .normal)
        loginButton.backgroundColor = colorScheme.model.baseColor
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = colorScheme.model.foregroundColor.cgColor
        
        createUserButton.setTitle("Create User", for: .normal)
        createUserButton.setTitleColor(colorScheme.model.foregroundColor, for: .normal)
        createUserButton.backgroundColor = colorScheme.model.baseColor
        createUserButton.layer.cornerRadius = 5
        createUserButton.layer.borderWidth = 2
        createUserButton.layer.borderColor = colorScheme.model.foregroundColor.cgColor
        
    }

}
