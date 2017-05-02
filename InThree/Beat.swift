//
//  Beat.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/16/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.


import Foundation
import AudioKit

struct Beat {
    
    var rhythm: Rhythm
    var notes = [Note]()
    var beatNumber: AKDuration = AKDuration(beats: 0)
    
    mutating func setBeatNumber(to beatNumber: AKDuration) {
        self.beatNumber = beatNumber
    }
    
}

extension Beat {
    
    init(rhythm: Rhythm) {
        self.rhythm = rhythm
        for i in 1...rhythm.rawValue {
            let position = AKDuration(beats: Double(i - 1) / rhythm.rawValue)
            let duration = AKDuration(beats: 1.0/rhythm.rawValue * 0.9)
            let note = Note(noteOn: false, noteNumber: 0, velocity: 127, duration: duration, position: position)
            self.notes.append(note)
        }
    }
    
    init?(dictionary: [String: Any]) {
        guard let rhythmRawValue = dictionary["rhythm"] as? Int else { return nil }
        guard let rhythm = Rhythm(rawValue: rhythmRawValue) else { return nil }
        self.rhythm = rhythm
        guard let notes = dictionary["notes"] as? [[String: Any]] else { return nil }
        for note in notes {
            let newNote = Note(dictionary: note)
            self.notes.append(newNote)
        }
        guard let beatNumber = dictionary["beatNumber"] as? Double else { return nil }
        self.beatNumber = AKDuration(beats: beatNumber)
    }
}

extension Beat {
    
    mutating func add(note: Note, forNewRhythm rhythm: Rhythm) {
        //continue tomorrow
    }

    func asDictionary() -> [String: Any] {
        var notesDict = [[String: Any]]()
        for note in notes {
            notesDict.append(note.asDictionary())
        }
        
        let beatDict: [String: Any] = [
            "rhythm": rhythm.rawValue,
            "notes": notesDict,
            "beatNumber": self.beatNumber.beats
        ]
        
        return beatDict
    }
    
    static func randomBeat(position: Double = 0) -> Beat {
        let rhythm: Rhythm = .four
        let notes = [Note.random(), Note.random(), Note.random(), Note.random()]
        return Beat(rhythm: rhythm, notes: notes, beatNumber: AKDuration(beats: position))
    }
}


