//
//  UserAlert.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/11/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import UIKit

protocol UserAlert {
    
    
    func alertUser(with message: String, viewController: UIViewController, completion: (() -> Void)?)
    
}

extension UserAlert {
    
    func alertUser(with message: String, viewController: UIViewController, completion: (() -> Void)?) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let completion = completion {
                completion()
            }
        }
        alert.addAction(alertAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
