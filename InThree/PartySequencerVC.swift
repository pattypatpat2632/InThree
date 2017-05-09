//
//  MultipeerSequencerVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/8/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class PartySequencerVC: SequencerVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MultipeerManager.sharedInstance.delegate = self
    }

}

extension PartySequencerVC: MultipeerManagerDelegate {
    
    func musicChanged(forUID uid: String, score: Score, manager: MultipeerManager) {
        for (index, blipUser) in selectedPeers.enumerated() {
            if blipUser.uid == uid {
                sequencerEngine.generateSequence(fromScore: score, forUserNumber: index + 1)
            }
        }
    }
    
    func connectionLost(forUID uid: String, manager: MultipeerManager) {
        for (index, blipUser) in self.selectedPeers.enumerated() {
            if blipUser.uid == uid {
                self.selectedPeers.remove(at: index)
            }
            //TODO: remove peer that has disconnected, and fade out their score
        }
    }
}
