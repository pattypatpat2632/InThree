//
//  ColorSchemeModel.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/24/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import UIKit

struct ColorSchemeModel {
    let baseColor: UIColor
    let backgroundColor: UIColor
    let highlightColor: UIColor
    let foregroundColor: UIColor
}

enum ColorScheme {
    case normal, paint, night, gameboy, flower, timeless
    
    var model: ColorSchemeModel {
        switch self {
        case .normal:
            return ColorSchemeModel(baseColor: UIColor.night, backgroundColor: UIColor.phoneBoothRed, highlightColor: UIColor.pearl, foregroundColor: UIColor.flash)
        case .paint:
            return ColorSchemeModel(baseColor: UIColor.ultraMarine, backgroundColor: UIColor.watermelon, highlightColor: UIColor.sunshine, foregroundColor: UIColor.turquoise)
        case .night:
            return ColorSchemeModel(baseColor: UIColor.nightCyan, backgroundColor: UIColor.nightMagenta, highlightColor: UIColor.nightYellow, foregroundColor: UIColor.nightBlack)
        case .gameboy:
            return ColorSchemeModel(baseColor: UIColor.lightestGreen, backgroundColor: .lightGreen, highlightColor: .darkestGreen, foregroundColor: .darkGreen)
        case .flower:
            return ColorSchemeModel(baseColor: UIColor.sky, backgroundColor: UIColor.sunset, highlightColor: UIColor.sunflower, foregroundColor: UIColor.grass)
        case .timeless:
            return ColorSchemeModel(baseColor: UIColor.ivory, backgroundColor: UIColor.navy, highlightColor: UIColor.candyApple, foregroundColor: UIColor.peacockBlue)
        }
    }
}
