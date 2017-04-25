//
//  SequencerVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/15/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import AudioKit


class SequencerVC: UIViewController {
    
    
    var sequencerEngine = SequencerEngine()
    var sequencerView = SequencerView()
    var score = Score()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = sequencerView
        
        sequencerEngine.setUpSequencer()
        
        for (index, beatView) in sequencerView.allBeatViews.enumerated() {
            beatView.delegate = self
            beatView.beatNumber = index
            score.add(beat: beatView.beat)
        }
        
    }
}

extension SequencerVC: BeatViewDelegate {
    func rhythmChange(forBeatView beatView: BeatView) {
        score.beats[beatView.beatNumber] = beatView.beat
        sequencerEngine.generateSequence(fromScore: score)
    }
    
    func noteChange(padIsOn: Bool, beatNumber: Int, padNumber: Int) {
        print("PAD ON: \(padIsOn) beatNumber: \(beatNumber) padNumber: \(padNumber)")
        if padIsOn {
            getNote(beatNumber: beatNumber, padNumber: padNumber)
        } else {
            score.beats[beatNumber].notes[padNumber].noteOn = false
            sequencerEngine.generateSequence(fromScore: score)
        }
    }
    
    func getNote(beatNumber: Int, padNumber: Int) {
        sequencerView.circleOfFifthsView.isHidden = false
        for beatView in sequencerView.allBeatViews {
            beatView.isUserInteractionEnabled = false
            beatView.alpha = beatView.alpha / 5
        }
        
        for noteButton in sequencerView.circleOfFifthsView.noteButtons {
            noteButton.beatNumber = beatNumber
            noteButton.padNumber = padNumber
            noteButton.delegate = self
        }
    }
}

extension SequencerVC: NoteButtonDelegate {
    
    func respondTo(noteNumber: MIDINoteNumber, atBeatNumber beatNumber: Int?, atPadNumber padNumber: Int?) {
        guard let beatNumber = beatNumber, let padNumber = padNumber else {return}
        score.beats[beatNumber].notes[padNumber].noteOn = true
        score.beats[beatNumber].notes[padNumber].noteNumber = noteNumber
        sequencerEngine.generateSequence(fromScore: score)
        
        sequencerView.circleOfFifthsView.isHidden = true
        for beatView in sequencerView.allBeatViews {
            beatView.isUserInteractionEnabled = true
            beatView.alpha = beatView.alpha * 5
        }
    }
}






