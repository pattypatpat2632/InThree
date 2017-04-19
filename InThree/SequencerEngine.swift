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
        //self.generateTestSequence()
        createTestScore()
        
        AudioKit.output = verb
        AudioKit.start()
        midiNode.enableMIDI(midi.client, name: "midiNode midi in")
        sequencer.setTempo(120.0)
        sequencer.enableLooping()
        sequencer.play()
        
    }
    
    func changeTempo(_ newTempo: Double) {
        sequencer.setTempo(newTempo)
    }
    
    func generateTestSequence() {
        sequencer.setLength(AKDuration(beats: 8.0))
        sequencer.tracks[0].clear()
        for i in 0...15 {
            sequencer.tracks[0].add(noteNumber: 60, velocity: 127, position: AKDuration(beats: Double(i)/2), duration: AKDuration(beats: 0.5))
        }
    }
    
    func generateSequence(fromScore score: Score) {
        sequencer.setLength(AKDuration(beats: Double(score.beats.count)))
        sequencer.tracks[0].clear()
        var beatPostion = AKDuration(beats: 0)
        for beat in score.beats {
            for note in beat.notes{
                sequencer.tracks[0].add(noteNumber: note.noteNumber, velocity: note.velocity, position: note.position + beatPostion, duration: note.duration)
            }
            beatPostion = beatPostion + AKDuration(beats: 1.0)
        }
    }
    
    func createTestScore(){
        var beat1 = Beat(rhythm: .two)
        beat1.notes[0].noteNumber = 60
        beat1.notes[0].noteOn = true
        beat1.notes[0].velocity = 127
        beat1.notes[1].noteNumber = 61
        beat1.notes[1].noteOn = true
        beat1.notes[1].velocity = 127
        
        var beat2 = Beat(rhythm: .one)
        beat2.notes[0].noteNumber = 63
        beat2.notes[0].noteOn = true
        beat2.notes[0].velocity = 127
        
        let score = Score(beats: [beat1, beat2])
        generateSequence(fromScore: score)
    }
    
}




















