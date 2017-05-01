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
        self.view = dashboardView
        dashboardView.delegate = self
    }
    
    func goToPartyMode() {//TODO: this function will probbly change as party mode is furthered
        let sequencerVC = SequencerVC()
        self.navigationController?.pushViewController(sequencerVC, animated: true)
    }
    
    func goToSoloMode() {
        let sequencerVC = SequencerVC()
        self.navigationController?.pushViewController(sequencerVC, animated: true)
    }

}
