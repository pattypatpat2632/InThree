//
//  InstructionsView.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/17/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class InstructionsView: UIView, BlipBloopView {

    let titleLabel = BlipLabel()
    let instructions = UITextView()
    let soloMode = UITextView()
    let partyMode = UITextView()
    
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
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 75).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        
        addSubview(instructions)
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        instructions.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        instructions.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        instructions.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        
        addSubview(soloMode)
        soloMode.translatesAutoresizingMaskIntoConstraints = false
        soloMode.topAnchor.constraint(equalTo: instructions.bottomAnchor, constant: 10).isActive = true
        soloMode.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        soloMode.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        soloMode.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        
        addSubview(partyMode)
        partyMode.translatesAutoresizingMaskIntoConstraints = false
        partyMode.topAnchor.constraint(equalTo: soloMode.bottomAnchor, constant: 10).isActive = true
        partyMode.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        partyMode.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        partyMode.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
    }
    
    func setSubviewProperties() {
        titleLabel.text = "Instructions:"
        titleLabel.changeFontSize(to: 28)
        
        instructions.isUserInteractionEnabled = false
        instructions.textAlignment = .center
        instructions.backgroundColor = colorScheme.model.baseColor
        instructions.textColor = colorScheme.model.foregroundColor
        instructions.font = UIFont(name: "TimeBurner", size: 20)
        instructions.text = "Tap on the squares to add or remove notes.\nSwipe left or right on each row to change the rhythm."
        
        soloMode.isUserInteractionEnabled = false
        soloMode.textAlignment = .center
        soloMode.backgroundColor = colorScheme.model.baseColor
        soloMode.textColor = colorScheme.model.foregroundColor
        soloMode.font = UIFont(name: "TimeBurner", size: 20)
        soloMode.text = "Solo Mode:\nPlay BlipBloop all by your lonesome"
        
        partyMode.isUserInteractionEnabled = false
        partyMode.textAlignment = .center
        partyMode.backgroundColor = colorScheme.model.baseColor
        partyMode.textColor = colorScheme.model.foregroundColor
        partyMode.font = UIFont(name: "TimeBurner", size: 20)
        partyMode.text = "Create Party:\nYou can connect and play BlipBloop with anybody nearby on the same WIFI network,\nor via Bluetooth"
    }

}
