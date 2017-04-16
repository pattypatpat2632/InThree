//
//  PadView.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/15/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class PadView: UIView {
    
    let button = UIButton()
    var buttonIsOn: Bool = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.ultraMarine
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9).isActive = true
        button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        button.backgroundColor = UIColor.sunshine
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        self.layer.cornerRadius = 5
        button.layer.cornerRadius = 5
        button.alpha = 0.5
    }
    
    func buttonPressed() {
        if buttonIsOn {
            buttonIsOn = false
            button.alpha = 0.5
        } else {
            buttonIsOn = true
            button.alpha = 1
        }
    }

}
