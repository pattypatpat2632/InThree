//
//  FriendFinderView.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/27/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class LocalPeerView: UIView, BlipBloopView {
    
    let titleLabel = BlipLabel()
    let peerTable = UITableView()
    let continueButton = BlipButton()
    var backButton = BlipButton()
    var delegate: LocalPeerViewDelegate?
    
    
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
    }
    
    func setConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        
        addSubview(peerTable)
        peerTable.translatesAutoresizingMaskIntoConstraints = false
        peerTable.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        peerTable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        peerTable.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        peerTable.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        continueButton.topAnchor.constraint(equalTo: peerTable.bottomAnchor, constant: 10).isActive = true
        continueButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        continueButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        
        self.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 10).isActive = true
        backButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        backButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        
    }
    
    func setSubviewProperties() {
        self.backgroundColor = colorScheme.model.baseColor
        
        titleLabel.text = "Select users to play music with:"
        titleLabel.changeFontSize(to: 24)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = colorScheme.model.foregroundColor
        
        peerTable.backgroundColor  = UIColor.clear
        
        continueButton.setTitle("Invite", for: .normal)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func continueButtonTapped() {
        self.indicateSelected(view: continueButton) {
            self.delegate?.goToPartySquencer()
        }
    }
    
    func backButtonTapped() {
        self.indicateSelected(view: backButton) {
            self.delegate?.returnToDashboard()
        }
        
    }
    
}

protocol LocalPeerViewDelegate {
    func goToPartySquencer()
    func returnToDashboard()
}
