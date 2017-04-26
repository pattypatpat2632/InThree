//
//  LoginManager.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

final class LoginManager {
    
    let userRef = FIRDatabase.database().reference().child("users")
    
    static func createUser(fromEmail email: String, password: String, username: String, completion:() -> Void) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (firUser, error) in
            
        })
    }
    
    
    
    
}
