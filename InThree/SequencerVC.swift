//
//  SequencerVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/15/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.


import UIKit
import AudioKit
import CoreLocation


class SequencerVC: UIViewController {
    
    
    var sequencerEngine = SequencerEngine()
    var sequencerView = SequencerView()
    var score = Score(rhythm: .four)
    var selectedPeers = [BlipUser]()
    var locationManager: CLLocationManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = sequencerView
        self.sequencerView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        
        sequencerEngine.setUpSequencer()
        switch sequencerEngine.mode {
        case .party:
            MultipeerManager.sharedInstance.delegate = self
        case .neighborhood( _):
            FirebaseManager.sharedInstance.delegate = self
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestAlwaysAuthorization()
            FirebaseManager.sharedInstance.observeAllScoresIn(locationID: "No Neighborhood")
        case .solo:
            print("sequencer entering solo mode")
        }
        
        for (index, beatView) in sequencerView.allBeatViews.enumerated() {
            beatView.delegate = self
            beatView.beatNumber = index
            for padView in beatView.allPads {
                padView.delegate = self
            }
        }
        
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

extension SequencerVC: NoteButtonDelegate {
    
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

extension SequencerVC: MultipeerManagerDelegate {
    
    func musicChanged(forUID uid: String, score: Score, manager: MultipeerManager) {
        for (index, blipUser) in selectedPeers.enumerated() {
            if blipUser.uid == uid {
                sequencerEngine.generateSequence(fromScore: score, forUserNumber: index + 1)
            }
        }
    }
    
    func connectionLost(forUID uid: String, manager: MultipeerManager) {
        for (index, blipUser) in self.selectedPeers.enumerated() {
            if blipUser.uid == uid {
                self.selectedPeers.remove(at: index)
            }
            //TODO: remove peer that has disconnected, and fade out their score
        }
    }
}

extension SequencerVC: SequencerViewDelegate {
    func returnToDashboard() {
        sequencerEngine.stopAll() //TODO: add audio fadeout
        navigationController?.popViewController(animated: true)
        
    }
}

//MARK: Core location delegate
extension SequencerVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            setLocationData()
        } else if status == .denied {
            returnToDashboard()
        }
    }
    
    func setLocationData() {
        print("LOCATION DATA BEING SET**************")
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            let title = "Flatiron"
            let coordinate = CLLocationCoordinate2DMake(40.705253, -74.014070)
            let regionRadius = 160934.0
            let clCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let region = CLCircularRegion(center: clCoordinate, radius: regionRadius, identifier: title)
            print("LOCATION MANAGER START MONITORING**************")
            locationManager?.startMonitoring(for: region)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("LOCATION MANAGER DID START MONITORING FOR REGION: \(region.identifier)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated")
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        print(state)
        print("region :\(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("DID ENTER REGION*****************")
        sequencerEngine.mode = .neighborhood(region.identifier)
        FirebaseManager.sharedInstance.observeAllScoresIn(locationID: region.identifier)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        //TODO: stop local sequence
        print("DID EXIT REGION*****************")
        sequencerEngine.mode = .neighborhood("No Neighborhood")
        sequencerEngine.sequencer.tracks[1].clear()
        FirebaseManager.sharedInstance.observeAllScoresIn(locationID: "No Neighborhood")
    }
    
}
//MARK: Location based sequencer
extension SequencerVC {
    func grabLocalSequence() {
        guard FirebaseManager.sharedInstance.allLocationScores.count > 0 else {return}
        let scoredIndex = UInt32(FirebaseManager.sharedInstance.allLocationScores.count - 1)
        let randNum = Int(arc4random_uniform(scoredIndex))
        let randomScore = FirebaseManager.sharedInstance.allLocationScores[randNum]
        sequencerEngine.generateSequence(fromScore: randomScore, forUserNumber: 1)
    }
}

extension SequencerVC: FirebaseManagerDelegate {
    func updateLocationScores() {
        grabLocalSequence()
    }
}





