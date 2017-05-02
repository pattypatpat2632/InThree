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
    func indicateSelected(view: UIView)
}

extension BlipBloopView where Self: UIView {
    
    var colorScheme: ColorScheme {
        get { return .paint }
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
    
    func indicateSelected(view: UIView) {
        UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: .calculationModeLinear, animations: {
            let holdColor = view.backgroundColor
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1, animations: {
                view.backgroundColor = self.colorScheme.model.highlightColor
                view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.1, animations: {
                view.backgroundColor = holdColor
                view.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }, completion: nil)
    }
    
}
