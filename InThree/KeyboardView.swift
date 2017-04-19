//
//  KeyboardView.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/18/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class KeyboardView: UIView {
    
    @IBOutlet var contentView: UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func commonInit() {
        Bundle.main.loadNibNamed("KeyboardView", owner: self, options: nil)
    }
}
