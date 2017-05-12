//
//  BlipTextField.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class BlipTextField: UITextField, BlipBloopView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = colorScheme.model.backgroundColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = colorScheme.model.highlightColor.cgColor
    }
}
