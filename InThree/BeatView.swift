//
//  BeatView.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/15/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.


import UIKit
import AudioKit

class BeatView: UIView, BlipBloopView {
    
    let pad0 = PadView()
    let pad1 = PadView()
    let pad2 = PadView()
    let pad3 = PadView()
    let pad4 = PadView()
    var allPads = [PadView]()
    let stackView = UIStackView()
    
    var delegate: BeatViewDelegate?
    
    var beat = Beat(rhythm: .four)
    var displayedViewCount: Int = 4
    
    
    var beatNumber: Int = 0 {
        didSet {
            numberPads()
        }
    }
    
    // MARK: Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        
        self.backgroundColor = colorScheme.model.baseColor
        self.layer.cornerRadius = 5
        
        allPads = [pad0, pad1, pad2, pad3, pad4]
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        for (index, padView) in allPads.enumerated() {
            stackView.addArrangedSubview(padView)
            padView.padIndex = ScoreIndex(beatIndex: self.beatNumber, noteIndex: index)
        }
        pad4.isHidden = true
        stackView.backgroundColor = colorScheme.model.baseColor
        
        let addPadGesture = UISwipeGestureRecognizer(target: self, action: #selector(addPad))
        addPadGesture.direction = .left
        self.addGestureRecognizer(addPadGesture)
        
        let subtractPadGesture = UISwipeGestureRecognizer(target: self, action: #selector(subtractPad))
        subtractPadGesture.direction = .right
        self.addGestureRecognizer(subtractPadGesture)
    }
    
    //MARK: Methods
    func addPad() {
        guard displayedViewCount < 5 else {return}
        let pad = stackView.arrangedSubviews[displayedViewCount] as! PadView
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                pad.isHidden = false
            })
        }, completion: nil)
        
        displayedViewCount += 1
        delegate?.addStep(forBeatNum: beatNumber, newStepCount: displayedViewCount)
    }
    
    func subtractPad() {
        guard displayedViewCount > 1 else {return}
        let pad = stackView.arrangedSubviews[displayedViewCount - 1] as! PadView
        pad.turnOff()
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                pad.isHidden = true
            })
        }, completion: nil)
        self.allPads[displayedViewCount - 1].turnOff()
        displayedViewCount -= 1
        delegate?.removeStep(forBeatNum: beatNumber, newStepCount: displayedViewCount)
    }
    
    func numberPads() {
        for (index, padView) in allPads.enumerated() {
            padView.padIndex = ScoreIndex(beatIndex: self.beatNumber, noteIndex: index)
        }
    }

    
}

// MARK: Delegate protocol
protocol BeatViewDelegate {
    func addStep(forBeatNum beatNum: Int, newStepCount steps: Int)
    func removeStep(forBeatNum beatNum: Int, newStepCount: Int)
}

