//
//  BlipLabel.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/9/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class BlipLabel: UILabel, BlipBloopView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        
        self.textAlignment = .center
        self.backgroundColor = UIColor.clear
        self.textColor = colorScheme.model.foregroundColor
        self.font = UIFont(name: "Comicate", size: 64)
    }
    
    func changeFontSize(to fontSize: CGFloat) {
        self.font = UIFont(name: "Comicate", size: fontSize)
    }
    

}
