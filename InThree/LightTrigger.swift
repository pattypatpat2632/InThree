//
//  LightTrigger.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/8/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import AudioKit

class LightTrigger {
    
    var delegate: LightTriggerDelegate?
    var timer: Timer?
    
    deinit {
        timer?.invalidate()
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
            self.delegate?.fired()
        }
    }
    
    func stop() {
        timer?.invalidate()
    }
}

protocol LightTriggerDelegate {
    
    func fired()
    
}
