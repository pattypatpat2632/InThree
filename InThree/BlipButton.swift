//
//  BlipButton.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/9/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class BlipButton: UIButton, BlipBloopView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        self.setTitleColor(colorScheme.model.foregroundColor, for: .normal)
        self.titleLabel?.font = UIFont(name: "Comicate", size: 28)
        self.backgroundColor = colorScheme.model.baseColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = colorScheme.model.foregroundColor.cgColor
    }

}
