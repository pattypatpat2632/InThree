//
//  FriendFinderVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/27/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class LocalPeerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let localPeerView = LocalPeerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = localPeerView
    }
    
    
}
