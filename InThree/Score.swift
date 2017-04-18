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
