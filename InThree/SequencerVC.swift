//
//  SequencerVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/15/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class SequencerVC: UIViewController {
    
    let beat1View = BeatView()
    let beat2View = BeatView()
    let beat3View = BeatView()
    let beat4View = BeatView()
    var sequencerEngine = SequencerEngine()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.night
        
        self.view.addSubview(beat1View)
        beat1View.translatesAutoresizingMaskIntoConstraints = false
        beat1View.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        beat1View.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        beat1View.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        beat1View.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
        beat1View.backgroundColor = UIColor.night
        
        self.view.addSubview(beat2View)
        beat2View.translatesAutoresizingMaskIntoConstraints = false
        beat2View.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        beat2View.topAnchor.constraint(equalTo: beat1View.bottomAnchor).isActive = true
        beat2View.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        beat2View.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
        beat2View.backgroundColor = UIColor.night
        
        self.view.addSubview(beat3View)
        beat3View.translatesAutoresizingMaskIntoConstraints = false
        beat3View.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        beat3View.topAnchor.constraint(equalTo: beat2View.bottomAnchor).isActive = true
        beat3View.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        beat3View.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
        beat3View.backgroundColor = UIColor.night
        
        self.view.addSubview(beat4View)
        beat4View.translatesAutoresizingMaskIntoConstraints = false
        beat4View.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        beat4View.topAnchor.constraint(equalTo: beat3View.bottomAnchor).isActive = true
        beat4View.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        beat4View.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
        beat4View.backgroundColor = UIColor.night
        
        sequencerEngine.setUpSequencer()
    }


}
