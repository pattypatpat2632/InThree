//
//  Score.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/16/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import AudioKit

struct Score {
    
    var beats = [Beat]()
    
    mutating func add(beat: Beat) {
        var newBeat = beat
        let beatNumber = AKDuration(beats: Double(beats.count))
        newBeat.setBeatNumber(to: beatNumber)
        beats.append(newBeat)
    }
    
}

extension Score {
    init?(dictionary: [String: Any]) {
        guard let beats = dictionary["beats"] as? [[String: Any]] else {return nil}
        for beat in beats {
            guard let newBeat = Beat(dictionary: beat) else { return nil }
            self.beats.append(newBeat)
        }
    }
}

extension Score {
    
    func asDictionary() -> [String: Any] {
        
        var beatDict = [[String: Any]]()
        for beat in beats {
            beatDict.append(beat.asDictionary())
        }
        let scoreDict = [
            "beats": beatDict
        ]
        return scoreDict
    }
    
    func asData() -> Data? {
        let scoreDict = self.asDictionary()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: scoreDict, options: [])
            return jsonData
        } catch {
            print("Could not convert dictionary to JSON Data")
            return nil
        }
    }
    
}
