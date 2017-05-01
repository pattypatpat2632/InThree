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
        FirebaseManager.sharedInstance.checkForCurrentUser { (userExists) in
            if userExists {
                self.view = self.dashboardView
                self.dashboardView.delegate = self
            } else {
                NotificationCenter.default.post(name: .closeDashboardVC, object: nil)
            }
        }
        
    }
    
    func goToPartyMode() {
        let localPeerVC = LocalPeerVC()
        self.navigationController?.pushViewController(localPeerVC, animated: true)
    }
    
    func goToSoloMode() {
        let sequencerVC = SequencerVC()
        self.navigationController?.pushViewController(sequencerVC, animated: true)
    }
    
    func goToNeighborhoodMode() {
        let sequencerVC = SequencerVC()
        sequencerVC.sequencerEngine.mode = .neighborhood
        self.navigationController?.pushViewController(sequencerVC, animated: true)//TODO: update if I decide to put a view in between dashboard and neighborhood sequencer
    }

}
