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
    
    init(uid: String, dictionary: [String: String]) {
        self.uid = uid
        self.name = dictionary["name"] ?? "No Name"
        self.email = dictionary["email"] ?? "No Email"
    }
    
    init?(jsonData: Data) {
        do {
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: [String: String]] else {return nil}
            self.init(dictionary: json)
        } catch {
            return nil
        }
    }
    
    init?(dictionary: [String: [String: String]]) {
        guard let uid = dictionary.keys.first else {return nil}
        self.uid = uid
        let properties = dictionary[uid] ?? [:]
        self.name = properties["name"] ?? "No name"
        self.email = properties["email"] ?? "No email"
    }
    
    func jsonData() -> Data? {
        let jsonDict = self.asDictionary()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict, options: [])
            return jsonData
        } catch {
            print("unable to write user as JSON data")
            return nil
        }
    }
    
    func asDictionary() -> [String: Any] {
        let dictionary = [
            self.uid: [
                "name": self.name,
                "email": self.email
            ]
        ]
        return dictionary
    }
}
