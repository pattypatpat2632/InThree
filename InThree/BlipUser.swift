//
//  BlipUser.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation

struct BlipUser {
    
    let name: String
    let uid: String
    let email: String
    
}

extension BlipUser {
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.name = dictionary["name"] as? String ?? "No Name"
        self.email = dictionary["email"] as? String ?? "No Email"
    }
}
