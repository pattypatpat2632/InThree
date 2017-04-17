//
//  SequencerEngine.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/16/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import AudioKit

struct SequencerEngine {
    
    
    let oscBank = AKOscillatorBank()
    let sequencer = AKSequencer()
    let midi = AKMIDI()
    var verb: AKReverb?
    
    init() {}
    
    mutating func setUpSequencer() {
        
        
        let midiNode = AKMIDINode(node: oscBank)
        
        oscBank.attackDuration = 0.1
        oscBank.decayDuration = 0.1
        oscBank.sustainLevel = 0.1
        oscBank.releaseDuration = 0.5
        verb = AKReverb(midiNode)
        
        _ = sequencer.newTrack()
        self.generateTestSequence()
        
        AudioKit.output = verb
        AudioKit.start()
        midiNode.enableMIDI(midi.client, name: "midiNode midi in")
        sequencer.setTempo(120.0)
        sequencer.enableLooping()
        sequencer.play()
    }
    
//    func changeNote(atBeat beat: Int, withNote note: Int, onMessage: Bool) {
//        if onMessage {
//            score.add(note: note, atBeat: beat)
//        } else {
//            score.turnOff(beat: beat)
//        }
//        generateSequence(fromScore: score)
//    }
    
    func changeTempo(_ newTempo: Double) {
        sequencer.setTempo(newTempo)
    }
    
//    func generateSequence(fromScore score: Score) {
//        let sheet = score.sheet
//        print("SEQUENCE GENERATED WITH SHEET: \(sheet)")
//        sequencer.setLength(AKDuration(beats: Double(score.steps/4)))
//        sequencer.tracks[0].clear()
//        let numberOfSteps = score.steps - 1
//        for i in 0 ... numberOfSteps {
//            if let notes = sheet[i] {
//                for note in notes {
//                    sequencer.tracks[0].add(noteNumber: MIDINoteNumber(note), velocity: 127, position: AKDuration(beats: Double(i)/4), duration: AKDuration(beats: 0.25))
//                }
//            }
//        }
//    }
    
    func generateTestSequence() {
        sequencer.setLength(AKDuration(beats: 8.0))
        sequencer.tracks[0].clear()
        for i in 0...15 {
            sequencer.tracks[0].add(noteNumber: 60, velocity: 127, position: AKDuration(beats: Double(i)/2), duration: AKDuration(beats: 0.5))
        }
    }
    
    func generateSequence(fromScore score: Score) {
        
    }
    
}




















