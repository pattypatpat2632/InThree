//
//  DashboardView.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class DashboardView: UIView, BlipBloopView {
    
    let soloModeButton = UIButton()
    let partyModeButton = UIButton()
    let neighborhoodModeButton = UIButton()
    var delegate: DashboardViewDelegate? = nil

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
    
    private func setConstraints() {
        addSubview(soloModeButton)
        soloModeButton.translatesAutoresizingMaskIntoConstraints = false
        soloModeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        soloModeButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        soloModeButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        soloModeButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        
        addSubview(partyModeButton)
        partyModeButton.translatesAutoresizingMaskIntoConstraints = false
        partyModeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        partyModeButton.topAnchor.constraint(equalTo: soloModeButton.bottomAnchor, constant: 10).isActive = true
        partyModeButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        partyModeButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        
        addSubview(neighborhoodModeButton)
        neighborhoodModeButton.translatesAutoresizingMaskIntoConstraints = false
        neighborhoodModeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        neighborhoodModeButton.topAnchor.constraint(equalTo: partyModeButton.bottomAnchor, constant: 10).isActive = true
        neighborhoodModeButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        neighborhoodModeButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        
    }
    
    private func setSubviewProperties() {
        partyModeButton.setTitle("Party Mode", for: .normal)
        partyModeButton.setTitleColor(colorScheme.model.foregroundColor, for: .normal)
        partyModeButton.backgroundColor = colorScheme.model.baseColor
        partyModeButton.layer.cornerRadius = 5
        partyModeButton.layer.borderWidth = 2
        partyModeButton.layer.borderColor = colorScheme.model.foregroundColor.cgColor
        partyModeButton.addTarget(self, action: #selector(partyModeButtonPressed), for: .touchUpInside)
        
        soloModeButton.setTitle("Solo Mode", for: .normal)
        soloModeButton.setTitleColor(colorScheme.model.foregroundColor, for: .normal)
        soloModeButton.backgroundColor = colorScheme.model.baseColor
        soloModeButton.layer.cornerRadius = 5
        soloModeButton.layer.borderWidth = 2
        soloModeButton.layer.borderColor = colorScheme.model.foregroundColor.cgColor
        soloModeButton.addTarget(self, action: #selector(soloModeButtonPressed), for: .touchUpInside)
        
        neighborhoodModeButton.setTitle("City Mode", for: .normal)
        neighborhoodModeButton.setTitleColor(colorScheme.model.foregroundColor, for: .normal)
        neighborhoodModeButton.backgroundColor = colorScheme.model.baseColor
        neighborhoodModeButton.layer.cornerRadius = 5
        neighborhoodModeButton.layer.borderWidth = 2
        neighborhoodModeButton.layer.borderColor = colorScheme.model.foregroundColor.cgColor
        neighborhoodModeButton.addTarget(self, action: #selector(neighborhoodModeButtonPressed), for: .touchUpInside)
        
    }
    
    func partyModeButtonPressed() {
        delegate?.goToPartyMode()
        //TODO: add some cool animation for button being pressed
    }
    
    func soloModeButtonPressed() {
        delegate?.goToSoloMode()
    }
    
    func neighborhoodModeButtonPressed() {
        delegate?.goToNeighborhoodMode()
    }
}

protocol DashboardViewDelegate {
    func goToPartyMode()
    func goToSoloMode()
    func goToNeighborhoodMode()
}
