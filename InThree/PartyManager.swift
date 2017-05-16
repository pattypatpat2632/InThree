//
//  PartyManager.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/16/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import Firebase

final class PartyManager {
    
    static let sharedInstance = PartyManager()
    let partiesRef = FIRDatabase.database().reference().child("parties")
    var delegate: PartyDelegate?
    private init() {}
    
    func send(score: Score) {
//        let dictionary = [
//            "score": score.asDictionary()
//        ]
//        do {
//            let scoreData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
//            if session.connectedPeers.count > 0 {
//                do {
//                    try self.session.send(scoreData, toPeers: session.connectedPeers, with: .reliable)
//                    print("Sent score to connected peers")
//                } catch{
//                    print("Errah")
//                }
//            }
//        } catch {
//            print("Could not JSONSerialize the score dictionary")
//        }
    }
    
}

protocol PartyDelegate {
    
    func musicChanged(forUID uid: String, score: Score, manager: MultipeerManager)
    
}
