//
//  BeatView.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/15/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class BeatView: UIView {
    
    let pad1 = PadView()
    let pad2 = PadView()
    let pad3 = PadView()
    let pad4 = PadView()
    let pad5 = PadView()
    var allPads = [PadView]()
    let stackView = UIStackView()
    let sliderView = UIView()
    let colorScheme: ColorScheme = .normal
    
    var delegate: BeatViewDelegate?
    
    var beat = Beat(rhythm: .four)
    var displayedViewCount: Int = 4
    
    
    var beatNumber: Int = 0
    
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
        allPads = [pad1, pad2, pad3, pad4, pad5]
        
        for (index, pad) in allPads.enumerated() {
            pad.padNumber = index
            pad.delegate = self
        }
        

        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6666).isActive = true
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(pad1)
        stackView.addArrangedSubview(pad2)
        stackView.addArrangedSubview(pad3)
        stackView.addArrangedSubview(pad4)
        stackView.addArrangedSubview(pad5)
        pad5.isHidden = true
        
        self.addSubview(sliderView)
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        sliderView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        sliderView.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        sliderView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        sliderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sliderView.backgroundColor = colorScheme.model.backgroundColor
        
        let addPadGesture = UISwipeGestureRecognizer(target: self, action: #selector(addPad))
        addPadGesture.direction = .left
        sliderView.addGestureRecognizer(addPadGesture)
        
        let subtractPadGesture = UISwipeGestureRecognizer(target: self, action: #selector(subtractPad))
        subtractPadGesture.direction = .right
        sliderView.addGestureRecognizer(subtractPadGesture)
    }
    
//MARK: Methods
    func addPad() {
        guard displayedViewCount < 5 else {return}
        let pad = stackView.arrangedSubviews[displayedViewCount]
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                pad.isHidden = false
            })
        }, completion: nil)
        displayedViewCount += 1
        reportBeatChange()
    }
    
    func subtractPad() {
        guard displayedViewCount > 1 else {return}
        let pad = stackView.arrangedSubviews[displayedViewCount - 1]
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                pad.isHidden = true
            })
        }, completion: nil)
        displayedViewCount -= 1
        reportBeatChange()
    }
    
    func reportBeatChange () {
        if let rhythm = Rhythm(rawValue: self.displayedViewCount) {
            beat = Beat(rhythm: rhythm)
            delegate?.beatChange(forBeat: beat)
        }
    }
    
}

extension BeatView: PadViewDelegate {
    func padValueChanged(padNumber: Int, padIsOn: Bool) {
        delegate?.noteChange(padIsOn: padIsOn, beatNumber: self.beatNumber, padNumber: padNumber)
    }
}

// MARK: Delegate protocol
protocol BeatViewDelegate {
    func beatChange(forBeat beat: Beat)
    func noteChange(padIsOn: Bool, beatNumber: Int, padNumber: Int)
}

