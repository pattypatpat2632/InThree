//
//  SequencerVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/15/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class SequencerVC: UIViewController {
    
    
    var sequencerEngine = SequencerEngine()
    var sequencerView = SequencerView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = sequencerView
        
        sequencerEngine.setUpSequencer()
        
        
    }


}
