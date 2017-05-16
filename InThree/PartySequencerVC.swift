//
//  MultipeerSequencerVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/8/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import AudioKit

class PartySequencerVC: SequencerVC {
    
    let allBlipUsers = FirebaseManager.sharedInstance.allBlipUsers
    
    var connectedPeers: [BlipUser] {
        var returnPeers = [BlipUser]()
        let sessionPeers = MultipeerManager.sharedInstance.session.connectedPeers
        for peer in sessionPeers {
            for blipUser in allBlipUsers {
                if blipUser.uid == peer.displayName {
                    returnPeers.append(blipUser)
                }
            }
        }
        return returnPeers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MultipeerManager.sharedInstance.delegate = self
        self.sequencerEngine.mode = .party
    }
    
    override func respondTo(noteNumber: MIDINoteNumber, scoreIndex: ScoreIndex) {
        super.respondTo(noteNumber: noteNumber, scoreIndex: scoreIndex)
    }
    
    override func returnToDashboard() {
        super.returnToDashboard()
        MultipeerManager.sharedInstance.startAdvertising()
    }

}

extension PartySequencerVC: MultipeerManagerDelegate {
    
    func musicChanged(forUID uid: String, score: Score, manager: MultipeerManager) {
        for (index, blipUser) in connectedPeers.enumerated() {
            if blipUser.uid == uid {
                sequencerEngine.generateSequence(fromScore: score, forUserNumber: index + 1)
            }
        }
    }
    
    func connectionLost(forUID uid: String, manager: MultipeerManager) {
        
    }
}
