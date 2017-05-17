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
    var creator: String?
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
        
        var membersDict = [String: Any]()
        for member in members {
            for (key, value) in member.asDictionary() {
                membersDict[key] = value
            }
            
        }
        
        let dictionary: [String: Any] = [
            "members": membersDict,
            "userTurnID": userTurnID,
            "turnCount": turnCount,
            "creator": creator ?? "No Creator"
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
    
    init(dictionary: [String: Any]) {
        guard let userTurnID = dictionary["userTurnID"] as? String else {return}
        guard let turnCount = dictionary["turnCount"] as? Int else {return }
        guard let creator = dictionary["creator"] as? String else {return}
        self.userTurnID = userTurnID
        self.turnCount = turnCount
        self.creator = creator
        
        var members = [BlipUser]()
        guard let membersDict = dictionary["members"] as? [String: [String: String]] else {return}
        for (key, value) in membersDict {
            let newMember = BlipUser(uid: key, dictionary: value )
            members.append(newMember)
        }
        self.members = members
    }
    
    
    
}

