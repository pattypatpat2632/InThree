//
//  DashboardVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController, DashboardViewDelegate {
    
    let dashboardView = DashboardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("logged in with user UID: \(LoginManager.sharedInstance.currentBlipUser?.uid)")
        self.view = dashboardView
        dashboardView.delegate = self
    }
    
    func goToPartyMode() {//TODO: this function will probbly change as party mode is furthered
        let localPeerVC = LocalPeerVC()
        self.navigationController?.pushViewController(localPeerVC, animated: true)
    }
    
    func goToSoloMode() {
        let sequencerVC = SequencerVC()
        self.navigationController?.pushViewController(sequencerVC, animated: true)
    }

}
