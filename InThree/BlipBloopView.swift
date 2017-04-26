//
//  BlipBloopView.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/26/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import UIKit

protocol BlipBloopView {
    var colorScheme: ColorScheme { get }
    
    func indicateRequired(fieldView: UIView)
}

extension BlipBloopView where Self: UIView {
    
    var colorScheme: ColorScheme {
        get { return .normal }
    }
    
    func indicateRequired(fieldView: UIView) {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeLinear, animations: {
            let holdColor = fieldView.backgroundColor
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
                fieldView.backgroundColor = self.colorScheme.model.highlightColor
                fieldView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                fieldView.backgroundColor = holdColor
                fieldView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }, completion: nil)
    }
    
}
