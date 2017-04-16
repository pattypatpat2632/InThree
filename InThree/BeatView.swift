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
    let stackView = UIStackView()
    let sliderView = UIView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.phoneBoothRed
        
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
        
        self.addSubview(sliderView)
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        sliderView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        sliderView.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        sliderView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        sliderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sliderView.backgroundColor = UIColor.watermelon
        
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(addPad))
        rightGesture.direction = .right
        sliderView.addGestureRecognizer(rightGesture)
        
        let leftGesuture = UISwipeGestureRecognizer(target: self, action: #selector(subtractPad))
        leftGesuture.direction = .left
        sliderView.addGestureRecognizer(leftGesuture)
    }

    func addPad() {
        guard stackView.arrangedSubviews.count < 5 else {return}
        let pad = PadView()
        self.stackView.addArrangedSubview(pad)
    }
    
    func subtractPad() {
        guard stackView.arrangedSubviews.count > 1 else {return}
        guard let pad = stackView.arrangedSubviews.last else {return}
        stackView.removeArrangedSubview(pad)
        pad.removeFromSuperview()
    }
}
