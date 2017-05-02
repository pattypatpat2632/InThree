//
//  SequencerVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/15/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import AudioKit
import CoreLocation


class SequencerVC: UIViewController {
    
    
    var sequencerEngine = SequencerEngine()
    var sequencerView = SequencerView()
    var score = Score()
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
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestWhenInUseAuthorization()
        case .solo:
            print("sequencer entering solo mode")
        }
        
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
        sequencerView.allBeatViews[beatNumber].beat.notes[padNumber].noteOn = true
        sequencerView.allBeatViews[beatNumber].beat.notes[padNumber].noteNumber = noteNumber
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
        if status == .authorizedWhenInUse {
            setLocationData()
        } else if status == .denied {
            returnToDashboard()
        }
    }
    
    func setLocationData() {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            let title = "Flatiron"
            let coordinate = CLLocationCoordinate2DMake(40.705253, -74.014070)
            let regionRadius = 300.0
            let clCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let region = CLCircularRegion(center: clCoordinate, radius: regionRadius, identifier: title)
            locationManager?.startMonitoring(for: region)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        sequencerEngine.mode = .neighborhood(region.identifier)
        grabLocalSequence()
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        //TODO: stop local sequence
    }
    
}
//MARK: Location based sequencer
extension SequencerVC {
    func grabLocalSequence() {
        let scoredIndex = UInt32(FirebaseManager.sharedInstance.allLocationScores.count - 1)
        let randNum = Int(arc4random_uniform(scoredIndex))
        let randomScore = FirebaseManager.sharedInstance.allLocationScores[randNum]
        sequencerEngine.generateSequence(fromScore: randomScore, forUserNumber: 1)
        
    }
}






