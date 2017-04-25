//
//  CircleOfFifthsView.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/19/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import AudioKit

class CircleOfFifthsView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var c: NoteButton!
    @IBOutlet weak var g: NoteButton!
    @IBOutlet weak var d: NoteButton!
    @IBOutlet weak var a: NoteButton!
    @IBOutlet weak var e: NoteButton!
    @IBOutlet weak var b: NoteButton!
    @IBOutlet weak var fS: NoteButton!
    @IBOutlet weak var cS: NoteButton!
    @IBOutlet weak var gS: NoteButton!
    @IBOutlet weak var dS: NoteButton!
    @IBOutlet weak var aS: NoteButton!
    @IBOutlet weak var f: NoteButton!
    @IBOutlet weak var octaveLabel: UILabel!
    
    var noteButtons = [NoteButton]()
    var octaveNumber: Int = 4 {
        didSet {
            self.octaveLabel.text = "Octave \(octaveNumber)"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("CircleOfFifthsView", owner: self, options: nil)
        let colorScheme: ColorScheme = .normal
        
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.layer.cornerRadius = contentView.bounds.width/2
        
        noteButtons = [c, cS, d, dS, e, f, fS, g, gS, a, aS, b]
        var noteCount: MIDINoteNumber = 60
        noteButtons = noteButtons.map { (noteButton) -> NoteButton in
            noteButton.noteValue = noteCount
            noteButton.layer.cornerRadius = noteButton.bounds.width/2
            noteCount += 1
            return noteButton
        }
        
        octaveLabel.text = "Octave 4"
        octaveLabel.backgroundColor = colorScheme.model.highlightColor
        octaveLabel.textColor = colorScheme.model.foregroundColor
        
    }
    
    @IBAction func octaveUpTapped(_ sender: UIButton) {
        guard octaveNumber < 7 else {return}
        noteButtons = noteButtons.map({ (noteButton) -> NoteButton in
            noteButton.noteValue = noteButton.noteValue + 12
            return noteButton
        })
        octaveNumber += 1
    }
    @IBAction func octaveDownTapped(_ sender: UIButton) {
        guard octaveNumber > 1 else {return}
        noteButtons = noteButtons.map({ (noteButton) -> NoteButton in
            noteButton.noteValue = noteButton.noteValue - 12
            return noteButton
        })
        octaveNumber -= 1
    }
    
}


