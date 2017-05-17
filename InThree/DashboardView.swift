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
    var delegate: DashboardViewDelegate? = nil
    let logoutButton = BlipButton()
    let instructionsButton = BlipButton()

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
        
        addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoutButton.topAnchor.constraint(equalTo: soloModeButton.bottomAnchor, constant: 10).isActive = true
        logoutButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        logoutButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
        addSubview(instructionsButton)
        instructionsButton.translatesAutoresizingMaskIntoConstraints = false
        instructionsButton.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 20).isActive = true
        instructionsButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        instructionsButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        instructionsButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        
    }
    
    private func setSubviewProperties() {
        partyModeButton.setTitle("Create Party", for: .normal)
        partyModeButton.addTarget(self, action: #selector(partyModeButtonPressed), for: .touchUpInside)
        
        soloModeButton.setTitle("Solo Mode", for: .normal)
        soloModeButton.addTarget(self, action: #selector(soloModeButtonPressed), for: .touchUpInside)
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        
        instructionsButton.setTitle("Instructions", for: .normal)
        instructionsButton.layer.borderWidth = 0
        instructionsButton.changeFontSize(to: 20)
        instructionsButton.addTarget(self, action: #selector(instructionsPressed), for: .touchUpInside)
        
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
    
    func logoutButtonPressed() {
        self.indicateSelected(view: logoutButton) {
            self.delegate?.logout()
        }
    }
    
    func instructionsPressed() {
        self.indicatePushed(view: instructionsButton) { 
            self.delegate?.goToInstructions()
        }
    }
}

protocol DashboardViewDelegate {
    func goToPartyMode()
    func goToSoloMode()
    func goToInstructions()
    func logout()
}
