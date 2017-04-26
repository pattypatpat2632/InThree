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
    
    static let sharedInstance = LoginManager()
    let userRef = FIRDatabase.database().reference().child("users")
    var currentBlipUser: BlipUser? = nil
    
    private init() {}
    
    func loginUser(fromEmail email: String, password: String, completion: @escaping (FirebaseResponse) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (firUser, error) in
            if error == nil {
                guard let uid = firUser?.uid else {
                    completion(.failure("Could not log in user"))
                    return
                }
                self.observeCurrentBlipUser(uid: uid, completion: {
                    completion(.success("Login successful for user: \(LoginManager.sharedInstance.currentBlipUser?.name ?? "No Name")"))
                })
            } else {
                completion(.failure("Could not log in user"))
            }
        })
    }
    
    private func observeCurrentBlipUser(uid: String, completion: @escaping () -> Void) {
        userRef.child("uid").observe(.value, with: { (snapshot) in
            let userProperties = snapshot.value as? [String: Any] ?? [:]
            self.currentBlipUser = BlipUser(uid: uid, dictionary: userProperties)
            completion()
        })
    }
    
    
}
