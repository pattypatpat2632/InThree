//
//  NoteButton.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/24/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import AudioKit

class NoteButton: UIButton {
    
    var noteValue: MIDINoteNumber = 60
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.layer.cornerRadius = self.bounds.width/5
        self.backgroundColor = UIColor.flash
    }
    
    func buttonTapped() {
        print("NOTE BUTTON TAPPED WITH NOTE VALUE : \(self.noteValue)")
    }
    
}


