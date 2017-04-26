//
//  FirebaseManager.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class FirebaseManager {
    
    let dataRef = FIRDatabase.database().reference()
    
    let sharedInstance = FirebaseManager()
    var allBlipUsers = [BlipUser]()
    
    private init() {
        sharedInstance.observeAllBlipUsers()
    }
    
    private func observeAllBlipUsers() {
        dataRef.child("users").observe(.value, with: { (snapshot) in
            self.allBlipUsers.removeAll()
            let userDictionary = snapshot.value as? [String: Any] ?? [:]
            for key in userDictionary.keys {
                let propertyDictionary = userDictionary[key] as? [String: Any] ?? [:]
                let newBlipUser = BlipUser(dictionary: propertyDictionary)
                self.allBlipUsers.append(newBlipUser)
            }
        })
    }
    
}
