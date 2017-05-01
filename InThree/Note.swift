//
//  Note.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/16/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import AudioKit

struct Note {
    
    var noteOn: Bool
    var noteNumber: MIDINoteNumber
    var velocity: MIDIVelocity
    var duration: AKDuration
    var position: AKDuration
    
}

extension Note {
    init(dictionary: [String: Any]) {//TODO: handle force unwraps betterer
        self.noteOn = dictionary["noteOn"] as! Bool
        self.noteNumber = MIDINoteNumber(dictionary["noteNumber"] as! Int)
        self.velocity = MIDIVelocity(dictionary["velocity"] as! Int)
        self.duration = AKDuration(beats: dictionary["duration"] as! Double)
        self.position = AKDuration(beats: dictionary["position"] as! Double)
    }
}

extension Note {
    
    func asDictionary() -> [String: Any] {
        let noteDict: [String: Any] = [
            "noteOn": noteOn,
            "noteNumber": Int(noteNumber),
            "velocity": Int(velocity),
            "duration": duration.beats,
            "position": position.beats
            
        ]
        return noteDict
    }
    
    static func random() -> Note {
        let noteOn: Bool = drand48() < 0.5
        let noteNumber = UInt8(arc4random_uniform(127))
        let velocity = UInt8(arc4random_uniform(127))
        let duration = AKDuration(beats: 0.25)
        let position = AKDuration(beats: Double(arc4random_uniform(3)))
        return Note(noteOn: noteOn, noteNumber: noteNumber, velocity: velocity, duration: duration, position: position)
    }
    
}

