//
//  FirebaseManager.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

final class FirebaseManager {
    
    static let sharedInstance = FirebaseManager()
    
    let dataRef = FIRDatabase.database().reference()
    let userRef = FIRDatabase.database().reference().child("users")
    let locationRef = FIRDatabase.database().reference().child("locations")
    var allBlipUsers = [BlipUser]()
    var allLocationScores = [Score]()
    var currentBlipUser: BlipUser? = nil
    var delegate: FirebaseManagerDelegate?
    
    private init() {}
    
    func observeAllBlipUsers(completion: @escaping (FirebaseResponse) -> Void) {
        dataRef.child("users").observe(.value, with: { (snapshot) in
            self.allBlipUsers.removeAll()
            if let userDictionary = snapshot.value as? [String: [String: String]] {
                for user in userDictionary {
                    let newBlipUser = BlipUser(uid: user.key, dictionary: user.value)
                    self.allBlipUsers.append(newBlipUser)
                }
                completion(.success("Updated all Blip users"))
            } else {
                completion(.failure("Could not observe Blip users"))
            }
        })
    }
    
    func createUser(fromEmail email: String, name: String, andPassword password: String, completion: @escaping (FirebaseResponse) -> Void) {
        print("create user called")
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (firUser, error) in
            guard let firUser = firUser else {completion(.failure("Could not create new user")); return} //TODO: handle possibility off different error types eg. invalid email or password
            let newBlipUser = BlipUser(name: name, uid: firUser.uid, email: email)
            self.storeNew(blipUser: newBlipUser) {
                completion(.success("New user created: \(newBlipUser.name)"))
                self.observeCurrentBlipUser(uid: newBlipUser.uid, completion: {
                })
            }
        })
    }
    
    private func storeNew(blipUser: BlipUser, completion: () -> Void) {
        let post = [
            "name": blipUser.name,
            "email": blipUser.email
        ]
        dataRef.child("users").child(blipUser.uid).updateChildValues(post)
        completion()
    }
    
}
//MARK: Login manager
extension FirebaseManager {
    func loginUser(fromEmail email: String, password: String, completion: @escaping (FirebaseResponse) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (firUser, error) in
            if error == nil {
                guard let uid = firUser?.uid else {
                    completion(.failure("Could not log in user"))
                    return
                }
                self.observeCurrentBlipUser(uid: uid, completion: {
                    completion(.success("Login successful for user: \(FirebaseManager.sharedInstance.currentBlipUser?.name ?? "No Name")"))
                })
            } else {
                completion(.failure("Could not log you in; check your email and password"))
            }
        })
    }
    
    func logoutUser(completion: @escaping (FirebaseResponse) -> Void) {
        do {
            try FIRAuth.auth()?.signOut()
            completion(.success("Logged out user"))
        } catch {
            completion(.failure("Could not log out user"))
        }
        
    }
    
    func checkForCurrentUser(completion: @escaping (Bool) -> Void) {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            completion(false)
            return
        }
        self.observeCurrentBlipUser(uid: uid) {
            completion(true)
        }
    }
    
    fileprivate func observeCurrentBlipUser(uid: String, completion: @escaping () -> Void) {
        userRef.child("uid").observe(.value, with: { (snapshot) in
            let userProperties = snapshot.value as? [String: String] ?? [:]
            self.currentBlipUser = BlipUser(uid: uid, dictionary: userProperties)
            completion()
        })
    }
    
    func resetPassword(from email: String, completion: @escaping (FirebaseResponse) -> Void) {
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                completion(.success("Check your email to reset your password"))
            } else {
                completion(.failure("Sorry, could not reset your password"))
            }
        })
    }
}

//MARK: City mode functions
extension FirebaseManager {
    
    func send(score: Score, toUUID uuid: String) {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        locationRef.child(uuid).child(uid).updateChildValues(score.asDictionary())
    }
    
    func observeAllScoresIn(locationID lid: String) {
        locationRef.observe(.value, with: { (snapshot) in
            self.allLocationScores.removeAll()
            let allLocations = snapshot.value as? [String: Any] ?? [:]
            for location in allLocations {
                if location.key == lid {
                    let allUsersInLocation = location.value as? [String: Any] ?? [:]
                    for user in allUsersInLocation {
                        if user.key != self.currentBlipUser?.uid {
                            let scoreDict = user.value as? [String: Any] ?? [:]
                            if let newScore = Score(dictionary: scoreDict) {
                                self.allLocationScores.append(newScore)
                            }
                        }
                    }
                }
            }
            self.delegate?.updateLocationScores()
        })
    }
}

protocol FirebaseManagerDelegate {
    func updateLocationScores()
}
