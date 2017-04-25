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
        score.add(beat: Beat(rhythm: .four))
        sequencerEngine.generateSequence(fromScore: score)
        
        for beatView in sequencerView.allBeatViews {
            beatView.delegate = self
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
}
