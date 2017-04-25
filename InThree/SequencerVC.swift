//
//  SequencerVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/15/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit


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
        }
        
    }
}

extension SequencerVC: BeatViewDelegate {
    func beatChange(forBeat beat: Beat) {
        score.beats.removeAll()
        for beatView in sequencerView.allBeatViews {
            score.add(beat: beatView.beat)
        }
        sequencerEngine.generateSequence(fromScore: score)
    }
    
    func noteChange(padIsOn: Bool, beatNumber: Int, padNumber: Int) {
        print("PAD ON: \(padIsOn) beatNumber: \(beatNumber) padNumber: \(padNumber)")
        if padIsOn {
            getNote {
                
            }
            score.beats[beatNumber].notes[padNumber].noteOn = true
            sequencerEngine.generateSequence(fromScore: score)
        } else {
            score.beats[beatNumber].notes[padNumber].noteOn = false
            sequencerEngine.generateSequence(fromScore: score)
        }
    }
    
    func getNote(completion: () -> Void){
        completion()
    }
}
