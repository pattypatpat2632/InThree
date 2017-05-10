//
//  ForgotPasswordView.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ForgotPasswordView: UIView, BlipBloopView {

    let titleLabel = BlipLabel()
    let emailField = UITextField()
    let passwordField = UITextField()
    let confirmField = UITextField()
    
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
        self.addSubview(titleLabel)
        
    }
    
    func setSubviewProperties() {
        
    }

}
