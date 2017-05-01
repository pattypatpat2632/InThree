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
    var mode: SequencerMode = .solo
    
    init() {}
    
    mutating func setUpSequencer() {
        
        
        let midiNode = AKMIDINode(node: oscBank)
        
        oscBank.attackDuration = 0.1
        oscBank.decayDuration = 0.1
        oscBank.sustainLevel = 0.1
        oscBank.releaseDuration = 0.5
        verb = AKReverb(midiNode)
        
        _ = sequencer.newTrack()
        _ = sequencer.newTrack()
        _ = sequencer.newTrack()
        _ = sequencer.newTrack()
        
        AudioKit.output = verb
        AudioKit.start()
        midiNode.enableMIDI(midi.client, name: "midiNode midi in")
        sequencer.setTempo(120.0)
        sequencer.setLength(AKDuration(beats: 4.0))
        sequencer.enableLooping()
        sequencer.play()
        
    }
    
    func changeTempo(_ newTempo: Double) {
        sequencer.setTempo(newTempo)
    }
    
    func generateSequence(fromScore score: Score, forUserNumber userNum: Int = 0) {
        print("*****Generate Sequence*****")
        sequencer.tracks[userNum].clear()
        print("sequencer length: \(score.beats.count)")
        var beatPostion = AKDuration(beats: 0)
        for beat in score.beats {
            for note in beat.notes{
                if note.noteOn {
                    sequencer.tracks[userNum].add(noteNumber: note.noteNumber, velocity: note.velocity, position: note.position + beatPostion, duration: note.duration)
                }
            }
            beatPostion = beatPostion + AKDuration(beats: 1.0)
        }
        if userNum == 0 {
            send(score: score)
        }
    }
    
    func send(score: Score) {
        if mode == .party {
            MultipeerManager.sharedInstance.send(score: score)
        } else if mode == .neighborhood {
            //TODO: send score to neighborhood
        }
    }
    
}




















