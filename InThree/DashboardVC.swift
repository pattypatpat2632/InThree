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
                
               // self.disableNeighborhoodMode()
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
        sequencerVC.sequencerEngine.mode = .neighborhood("No Neighborhood")
        self.navigationController?.pushViewController(sequencerVC, animated: true)//TODO: update if I decide to put a view in between dashboard and neighborhood sequencer
    }
    
    func logout() {
        FirebaseManager.sharedInstance.logoutUser { (response) in
            switch response {
            case .success(let logoutString):
                print(logoutString)
                NotificationCenter.default.post(name: .closeDashboardVC, object: nil)
            case .failure(let failString):
                print(failString)
            }
        }
        
    }
    
    func disableNeighborhoodMode() {
        self.dashboardView.neighborhoodModeButton.alpha = 0.5
        self.dashboardView.neighborhoodModeButton.isUserInteractionEnabled = false
        
        let disabledLabel = UILabel()
        
        self.dashboardView.addSubview(disabledLabel)
        disabledLabel.translatesAutoresizingMaskIntoConstraints = false
        disabledLabel.topAnchor.constraint(equalTo: dashboardView.neighborhoodModeButton.bottomAnchor, constant: 10).isActive = true
        disabledLabel.centerXAnchor.constraint(equalTo: dashboardView.centerXAnchor).isActive = true
        disabledLabel.heightAnchor.constraint(equalTo: dashboardView.heightAnchor, multiplier: 0.05).isActive = true
        disabledLabel.widthAnchor.constraint(equalTo: dashboardView.widthAnchor).isActive = true
        disabledLabel.textAlignment = .center
        disabledLabel.text = "City Mode Coming Soon"
        disabledLabel.textColor = UIColor.red
    }

}
