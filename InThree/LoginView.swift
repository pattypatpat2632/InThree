//
//  LoginView.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class LoginView: UIView, BlipBloopView {
    
    let titleLabel = BlipLabel()
    let emailField = BlipTextField()
    let passwordField = BlipTextField()
    let loginButton = BlipButton()
    let createUserButton = BlipButton()
    let forgotPasswordButton = BlipButton()
    let creditsButton = BlipButton()

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
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
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
        loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        loginButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
        addSubview(createUserButton)
        createUserButton.translatesAutoresizingMaskIntoConstraints = false
        createUserButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        createUserButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        createUserButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        createUserButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
        addSubview(forgotPasswordButton)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.topAnchor.constraint(equalTo: createUserButton.bottomAnchor, constant: 10).isActive = true
        forgotPasswordButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        forgotPasswordButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        
        addSubview(creditsButton)
        creditsButton.translatesAutoresizingMaskIntoConstraints = false
        creditsButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 50).isActive = true
        creditsButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        creditsButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        creditsButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true

    }
    
    func setSubviewProperties() {
        self.backgroundColor = colorScheme.model.baseColor
        
        titleLabel.text = "BlipBloop"
        
        emailField.placeholder = "Email"
        emailField.textAlignment = .center

        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.textAlignment = .center
        
        loginButton.setTitle("LOGIN", for: .normal)
        createUserButton.setTitle("CREATE USER", for: .normal)
        
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.layer.borderWidth = 0
        forgotPasswordButton.changeFontSize(to: 20)
        
        creditsButton.setTitle("About BlipBlip", for: .normal)
        creditsButton.layer.borderWidth = 0
        creditsButton.changeFontSize(to: 18)
        
    }

}
