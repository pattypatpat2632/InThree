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
    
    var duration: AKDuration
    var position: AKDuration
    var noteNumber: MIDINoteNumber
    var velocity: MIDIVelocity
    
}
