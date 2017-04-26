//
//  SequencerView.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/17/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class SequencerView: UIView, BlipBloopView {
    
    let beat1View = BeatView()
    let beat2View = BeatView()
    let beat3View = BeatView()
    let beat4View = BeatView()
    let circleOfFifthsView = CircleOfFifthsView()

    var allBeatViews = [BeatView]()

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func setUpViews() {
        self.backgroundColor = colorScheme.model.baseColor
        
        self.addSubview(beat1View)
        beat1View.translatesAutoresizingMaskIntoConstraints = false
        beat1View.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        beat1View.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        beat1View.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        beat1View.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5).isActive = true
        beat1View.backgroundColor = colorScheme.model.baseColor
        
        self.addSubview(beat2View)
        beat2View.translatesAutoresizingMaskIntoConstraints = false
        beat2View.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        beat2View.topAnchor.constraint(equalTo: beat1View.bottomAnchor).isActive = true
        beat2View.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        beat2View.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5).isActive = true
        beat2View.backgroundColor = colorScheme.model.baseColor
        
        self.addSubview(beat3View)
        beat3View.translatesAutoresizingMaskIntoConstraints = false
        beat3View.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        beat3View.topAnchor.constraint(equalTo: beat2View.bottomAnchor).isActive = true
        beat3View.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        beat3View.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5).isActive = true
        beat3View.backgroundColor = colorScheme.model.baseColor
        
        self.addSubview(beat4View)
        beat4View.translatesAutoresizingMaskIntoConstraints = false
        beat4View.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        beat4View.topAnchor.constraint(equalTo: beat3View.bottomAnchor).isActive = true
        beat4View.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        beat4View.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5).isActive = true
        beat4View.backgroundColor = colorScheme.model.baseColor
        
        self.addSubview(circleOfFifthsView)
        circleOfFifthsView.translatesAutoresizingMaskIntoConstraints = false
        circleOfFifthsView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        circleOfFifthsView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        circleOfFifthsView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        circleOfFifthsView.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        circleOfFifthsView.isHidden = true
        
        allBeatViews = [beat1View, beat2View, beat3View, beat4View]
    }

}


