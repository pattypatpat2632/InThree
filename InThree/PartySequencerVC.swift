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
    
    var party = MultipeerManager.sharedInstance.party
    var userTurn: Bool = false {
        didSet {
            print("USER TURN; \(userTurn)")
            if userTurn == true {
              enableTurn()
            } else {
                disableTurn()
            }
        }
    }
    
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
        MultipeerManager.sharedInstance.startBrowsing()
    }
    
    override func respondTo(noteNumber: MIDINoteNumber, scoreIndex: ScoreIndex) {
        super.respondTo(noteNumber: noteNumber, scoreIndex: scoreIndex)
        userTurn = false
        party.nextTurn()
        MultipeerManager.sharedInstance.update(party)
    }
    
    func enableTurn() {
        print("Enabled turn")
        for subview in sequencerView.subviews {
            subview.alpha = 1.0
            subview.isUserInteractionEnabled = true
        }
    }
    
    func disableTurn() {
        print("Disabled turn")
        for subview in sequencerView.subviews {
            subview.alpha = 0.5
            subview.isUserInteractionEnabled = false
        }
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
    
    func partyChanged() {
        self.party = MultipeerManager.sharedInstance.party
        guard let uid = FirebaseManager.sharedInstance.currentBlipUser?.uid else {return}
        if party.userTurnID == uid {
            userTurn = true
        } else {
            userTurn = false
        }
    }
    
    func connectionLost(forUID uid: String, manager: MultipeerManager) {
        
    }
}
