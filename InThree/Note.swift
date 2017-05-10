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
    
}

extension Note {
    init(dictionary: [String: Any]) {//TODO: handle force unwraps betterer
        self.noteOn = dictionary["noteOn"] as! Bool
        self.noteNumber = MIDINoteNumber(dictionary["noteNumber"] as! Int)
        self.velocity = MIDIVelocity(dictionary["velocity"] as! Int)

    }
}

extension Note {
    
    func asDictionary() -> [String: Any] {
        let noteDict: [String: Any] = [
            "noteOn": noteOn,
            "noteNumber": Int(noteNumber),
            "velocity": Int(velocity),
        ]
        return noteDict
    }
    
    static func random() -> Note {
        let noteOn: Bool = drand48() < 0.5
        let noteNumber = UInt8(arc4random_uniform(127))
        let velocity = UInt8(arc4random_uniform(127))
        return Note(noteOn: noteOn, noteNumber: noteNumber, velocity: velocity)
    }
    
}

