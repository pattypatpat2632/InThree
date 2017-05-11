//
//  CreditsView.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/11/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class CreditsView: UIView, BlipBloopView {
    
    let titleLabel = BlipLabel()
    let creditsView = UITextView()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        setConstraints()
        setSubviewProperties()
        
        self.backgroundColor = colorScheme.model.baseColor
    }
    
    
    func setConstraints() {
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        
        addSubview(creditsView)
        creditsView.translatesAutoresizingMaskIntoConstraints = false
        creditsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        creditsView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        creditsView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        creditsView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
    }
    
    func setSubviewProperties() {
        titleLabel.text = "About BlipBlip:"
        titleLabel.changeFontSize(to: 28)
        
        creditsView.textAlignment = .center
        creditsView.backgroundColor = colorScheme.model.baseColor
        creditsView.textColor = colorScheme.model.foregroundColor
        creditsView.font = UIFont(name: "TimeBurner", size: 20)
        creditsView.text = "Hi! I'm Pat!\nI made BlipBloop.\nYou can reach me at patoleary.dev@gmail.com"
    }
}
