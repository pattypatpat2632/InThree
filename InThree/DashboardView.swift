//
//  DashboardView.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class DashboardView: UIView, BlipBloopView {
    
    let soloModeButton = BlipButton()
    let partyModeButton = BlipButton()
    let neighborhoodModeButton = BlipButton()
    var delegate: DashboardViewDelegate? = nil
    let logoutButton = BlipButton()

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
        soloModeButton.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        soloModeButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        soloModeButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
        addSubview(partyModeButton)
        partyModeButton.translatesAutoresizingMaskIntoConstraints = false
        partyModeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        partyModeButton.topAnchor.constraint(equalTo: soloModeButton.bottomAnchor, constant: 10).isActive = true
        partyModeButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        partyModeButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
        addSubview(neighborhoodModeButton)
        neighborhoodModeButton.translatesAutoresizingMaskIntoConstraints = false
        neighborhoodModeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        neighborhoodModeButton.topAnchor.constraint(equalTo: partyModeButton.bottomAnchor, constant: 10).isActive = true
        neighborhoodModeButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        neighborhoodModeButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
        addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoutButton.topAnchor.constraint(equalTo: neighborhoodModeButton.bottomAnchor, constant: 10).isActive = true
        logoutButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        logoutButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
    }
    
    private func setSubviewProperties() {
        partyModeButton.setTitle("Party Mode", for: .normal)
        partyModeButton.addTarget(self, action: #selector(partyModeButtonPressed), for: .touchUpInside)
        
        soloModeButton.setTitle("Solo Mode", for: .normal)
        soloModeButton.addTarget(self, action: #selector(soloModeButtonPressed), for: .touchUpInside)
        
        neighborhoodModeButton.setTitle("City Mode", for: .normal)
        neighborhoodModeButton.addTarget(self, action: #selector(neighborhoodModeButtonPressed), for: .touchUpInside)
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        
    }
    
    func partyModeButtonPressed() {
        self.indicateSelected(view: partyModeButton) {
            self.delegate?.goToPartyMode()
        }
    }
    
    func soloModeButtonPressed() {
        self.indicateSelected(view: soloModeButton) {
            self.delegate?.goToSoloMode()
        }
    }
    
    func neighborhoodModeButtonPressed() {
        self.indicateSelected(view: neighborhoodModeButton) {
            self.delegate?.goToNeighborhoodMode()
        }
    }
    
    func logoutButtonPressed() {
        self.indicateSelected(view: logoutButton) {
            self.delegate?.logout()
        }
    }
}

protocol DashboardViewDelegate {
    func goToPartyMode()
    func goToSoloMode()
    func goToNeighborhoodMode()
    func logout()
}
