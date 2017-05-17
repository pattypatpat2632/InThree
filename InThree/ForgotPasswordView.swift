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
    let submitButton = BlipButton()
    let backButton = BlipButton()
    var delegate: ForgotPasswordViewDelegate?
    
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
        
        addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 5).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        submitButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
        addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 5).isActive = true
        backButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        backButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
    }
    
    func setSubviewProperties() {
        titleLabel.text = "Reset Password"
        titleLabel.changeFontSize(to: 24)
        
        emailField.placeholder = "Email"
        emailField.textAlignment = .center
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
    }
    
    func submitTapped() {
        self.delegate?.submit()
    }
    
    func backTapped() {
        self.delegate?.goBack()
    }
    
}

protocol ForgotPasswordViewDelegate {
    func submit()
    func goBack()
}
