//
//  Party.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation

struct Party {
    
    var members = [BlipUser]()
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
    
//    func asDicionary() -> [String: Any] {
//        
//        
//        
//    }
//    
//    func asData() -> Data {
//        
//        
//        
//    }
    
}
