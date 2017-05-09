//
//  NoteButton.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/24/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import AudioKit

class NoteButton: UIButton, BlipBloopView {
    
    var noteValue: MIDINoteNumber = 60
    var scoreIndex: ScoreIndex?
    var delegate: NoteButtonDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        colorScheme.model.foregroundColor.setFill()
        path.fill()
    }
    
    func commonInit() {
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.setTitleColor(colorScheme.model.backgroundColor, for: .normal)
        self.backgroundColor = UIColor.clear
    }
    
    func buttonTapped() {
        print("NOTE BUTTON TAPPED WITH NOTE VALUE : \(self.noteValue)")
        guard let scoreIndex = scoreIndex else {return}
        self.indicatePushed(view: self) {
            self.delegate?.respondTo(noteNumber: self.noteValue, scoreIndex: scoreIndex)
        }
    }
    
}

protocol NoteButtonDelegate {
    func respondTo(noteNumber: MIDINoteNumber, scoreIndex: ScoreIndex)
}




