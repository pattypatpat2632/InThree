//
//  SequencerVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/15/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.


import UIKit
import AudioKit
import CoreLocation



class SequencerVC: UIViewController, NoteButtonDelegate {
    
    
    var sequencerEngine = SequencerEngine()
    var sequencerView = SequencerView()
    var score = Score(rhythm: .four)
    
    var lightTrigger = LightTrigger()
    var beatToLight: Int = 0
    var currentUser = FirebaseManager.sharedInstance.currentBlipUser
    
    
    override func viewDidLoad() {
        FirebaseManager.sharedInstance.currentBlipUser?.isInParty = true
        super.viewDidLoad()
        self.view = sequencerView
        self.sequencerView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        
        lightTrigger.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(startLightTrigger), name: .playbackStarted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopLightTrigger), name: .playbackStopped, object: nil)
        
        sequencerEngine.setUpSequencer()
        
        for (index, beatView) in sequencerView.allBeatViews.enumerated() {
            beatView.delegate = self
            beatView.beatNumber = index
            for padView in beatView.allPads {
                padView.delegate = self
            }
        }
    }
    
//MARK: Note button delegate
    func respondTo(noteNumber: MIDINoteNumber, scoreIndex: ScoreIndex) {
        score.beats[scoreIndex.beatIndex].notes[scoreIndex.noteIndex].noteNumber = noteNumber
        score.beats[scoreIndex.beatIndex].notes[scoreIndex.noteIndex].velocity = 127
        score.beats[scoreIndex.beatIndex].notes[scoreIndex.noteIndex].noteOn = true
        
        sequencerEngine.generateSequence(fromScore: score)
        
        sequencerView.circleOfFifthsView.isHidden = true
        sequencerView.allViews = sequencerView.allViews.map({ (uiView) -> UIView in
            uiView.alpha = uiView.alpha * 5
            uiView.isUserInteractionEnabled = true
            return uiView
        })
    }
}

extension SequencerVC: BeatViewDelegate {
    
    func addStep(forBeatNum beatNum: Int, newStepCount steps: Int) {
        guard let newRhythm = Rhythm(rawValue: steps) else {return}
        score.addStep(toBeatNum: beatNum, newRhythm: newRhythm)
        sequencerEngine.generateSequence(fromScore: score)
    }
    
    func removeStep(forBeatNum beatNum: Int, newStepCount: Int) {
        guard let newRhythm = Rhythm(rawValue: newStepCount) else {return}
        score.addStep(toBeatNum: beatNum, newRhythm: newRhythm)
        sequencerEngine.generateSequence(fromScore: score)
    }
}

extension SequencerVC: PadViewDelegate {
    func padValueChanged(scoreIndex: ScoreIndex, padIsOn: Bool) {
        if padIsOn {
            displayNoteView(scoreIndex: scoreIndex)
        } else {
            score.beats[scoreIndex.beatIndex].notes[scoreIndex.noteIndex].noteOn = false
            sequencerEngine.generateSequence(fromScore: score)
        }
    }
    
    func displayNoteView(scoreIndex: ScoreIndex) {
        sequencerView.allViews = sequencerView.allViews.map({ (uiView) -> UIView in
            uiView.alpha = uiView.alpha/5
            uiView.isUserInteractionEnabled = false
            return uiView
        })
        sequencerView.circleOfFifthsView.isHidden = false
        sequencerView.circleOfFifthsView.noteButtons = sequencerView.circleOfFifthsView.noteButtons.map({ (noteButton) -> NoteButton in
            noteButton.delegate = self
            noteButton.scoreIndex = scoreIndex
            return noteButton
        })
        
    }
}

extension SequencerVC: SequencerViewDelegate {
    func returnToDashboard() {
        FirebaseManager.sharedInstance.currentBlipUser?.isInParty = false
        sequencerEngine.stopAll() //TODO: add audio fadeout
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension SequencerVC: LightTriggerDelegate {
    
    func startLightTrigger() {
        lightTrigger.start()
    }
    
    func stopLightTrigger() {
        lightTrigger.stop()
    }
    
    func fired() {
        if beatToLight < 3 {
            self.sequencerView.allBeatViews[beatToLight].allPads = self.sequencerView.allBeatViews[beatToLight].allPads.map({ (padView) -> PadView in
                padView.backgroundColor = self.sequencerView.colorScheme.model.baseColor
                return padView
            })
            beatToLight += 1
            self.sequencerView.allBeatViews[beatToLight].allPads = self.sequencerView.allBeatViews[beatToLight].allPads.map({ (padView) -> PadView in
                padView.backgroundColor = self.sequencerView.colorScheme.model.backgroundColor
                return padView
            })
        } else {
            self.sequencerView.allBeatViews[beatToLight].allPads = self.sequencerView.allBeatViews[beatToLight].allPads.map({ (padView) -> PadView in
                padView.backgroundColor = self.sequencerView.colorScheme.model.baseColor
                return padView
            })
            beatToLight = 0
            self.sequencerView.allBeatViews[beatToLight].allPads = self.sequencerView.allBeatViews[beatToLight].allPads.map({ (padView) -> PadView in
                padView.backgroundColor = self.sequencerView.colorScheme.model.backgroundColor
                return padView
            })
        }
    }
}





