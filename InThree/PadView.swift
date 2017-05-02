//
//  PadView.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/15/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import AudioKit

class PadView: UIView, BlipBloopView {
    
    let button = UIButton()
    var buttonIsOn: Bool = false
    var padIndex = ScoreIndex(beatIndex: 0, noteIndex: 0)
    var delegate: PadViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = colorScheme.model.highlightColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9).isActive = true
        button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        button.backgroundColor = colorScheme.model.foregroundColor
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        self.layer.cornerRadius = 5
        button.layer.cornerRadius = 5
        button.alpha = 0.5
    }
    
    func buttonPressed() {
        if buttonIsOn {
            buttonIsOn = false
            button.alpha = 0.5
            delegate?.padValueChanged(scoreIndex: padIndex, padIsOn: false)
        } else {
            buttonIsOn = true
            button.alpha = 1
            delegate?.padValueChanged(scoreIndex: padIndex, padIsOn: true)
        }
    }
    
    func turnOff() {
        self.buttonIsOn = false
        self.button.alpha = 0.5
        delegate?.padValueChanged(scoreIndex: padIndex, padIsOn: false)
    }
    
    func setIndex(to scoreIndex: ScoreIndex) {
        self.padIndex = scoreIndex
    }
}

protocol PadViewDelegate {
    func padValueChanged(scoreIndex: ScoreIndex, padIsOn: Bool)
}



