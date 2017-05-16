//
//  Party.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation

struct Party {
    
    var id: String? = nil
    var members = [BlipUser]()
    var creator: BlipUser
    var userTurnID: String = ""
    var turnCount: Int = 0
    
    mutating func add(member: BlipUser) {
        self.members.append(member)
    }
    
    mutating func nextTurn() {
        if turnCount < members.count - 1{
            turnCount += 1
            userTurnID = members[turnCount].uid
        } else {
            turnCount = 0
            userTurnID = members[turnCount].uid
        }
    }
    
    func asDictionary() -> [String: Any] {
        let dictionary: [String: Any] = [
            "members": members.map{$0.asDictionary()},
            "userTurnID": userTurnID,
            "turnCount": turnCount
        ]
       return dictionary
    }
    
    func asData() -> Data? {
        let dictionary = self.asDictionary()
        do {
           let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            return data
        } catch {
            return nil
        }
    }
}

extension Party {
    
    init?(data: Data?){
        guard let data = data else {return nil}
        do{
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return nil}
            
            self.init(dictionary: json)
            
        } catch {
            return nil
        }
    }
    
    init?(dictionary: [String: Any]) {
        guard let userTurnID = dictionary["userTurnID"] as? String else {return nil}
        guard let turnCount = dictionary["turnCount"] as? Int else {return nil}
        guard let creator = dictionary["creator"] as? BlipUser else {return nil}
        self.userTurnID = userTurnID
        self.turnCount = turnCount
        self.creator = creator
        
        guard let membersArray = dictionary["members"] as? [[String: [String: String]]] else {return nil}
        self.members.removeAll()
        for member in membersArray {
            if let newMember = BlipUser(dictionary: member) {
                self.members.append(newMember)
            }
        }
    }
    
}
