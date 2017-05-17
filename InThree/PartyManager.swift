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
    let currentUser = FirebaseManager.sharedInstance.currentBlipUser
    let partiesRef = FIRDatabase.database().reference().child("parties")
    var delegate: PartyDelegate?
    var party = Party()
    var partyScores = [Score]()
    private init() {}
    
    func newParty(byUser user: BlipUser, completion: @escaping (String) -> Void) { //Create new party in firebase
        let partyID = partiesRef.childByAutoId().key
        let party = Party(id: partyID, members: [user], creator: user, userTurnID: user.uid, turnCount: 0)
        partiesRef.child(partyID).setValue(party.asDictionary())
        self.party.id = partyID
        completion(partyID)
        print("new party with party id: \(partyID)")
    }
    
    func observe(partyWithID partyID: String) {
        partiesRef.child(partyID).observe(.value, with: { (snapshot) in
            if let partyValues = snapshot.value as? [String: Any]{
                guard let party = Party(dictionary: partyValues) else {return}
                self.party = party
                self.party.id = partyID
            }
            self.delegate?.partyChange()
        })
    }
    
    func remove(member: BlipUser, fromPartyID partyID: String, completion: @escaping () -> Void) {
        partiesRef.child(partyID).child("members").child(member.uid).removeValue { (error, reference) in
            completion()
        }
    }
    
    func join(partyWithID partyID: String, completion: @escaping () -> Void) {
        if let currentUserDict = currentUser?.asDictionary() {
            for (key, value) in currentUserDict {
                partiesRef.child(partyID).child("members").child(key).setValue(value)
            }
        }
        self.party.id = partyID
        completion()
    }
}

//MARK: Score functions
extension PartyManager {
    
    func send(score: Score, toPartyID partyID: String) {
        print("SEND SCORE CALLED")
        guard let uid = currentUser?.uid else {return} //TODO: error
        print("CURRENT USER HAS VALID ID, SENDING SCORE")
        partiesRef.child(partyID).child("scores").child(uid).updateChildValues(score.asDictionary())
    }
    
    func observeAllScoresIn(partyID: String) {
        partiesRef.child(partyID).child("scores").observe(.value, with: { (snapshot) in
            self.partyScores.removeAll()
            if let userScores = snapshot.value as? [String: Any] {
                for (uid, score) in userScores {
                    let newScore = Score(dictionary: score as! [String: Any]) //TODO: refactor
                    if uid != self.currentUser?.uid {
                        self.delegate?.scoreChange(forUID: uid, score: newScore!)
                    }
                }
            }
        })
    }
}

protocol PartyDelegate {
    
    func scoreChange(forUID uid: String, score: Score)
    func partyChange()
    
}


