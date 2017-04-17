//
//  Rhythm.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/16/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation

enum Rhythm: String {
    case one, two, three, four, five
    
    mutating func setValue(fromString str: String) {
        switch str {
        case "one":
            self = .one
            case "two":
            self = .two
            case "three":
            self = .three
            case "four":
            self = .four
            case "five":
            self = .five
        default:
            print("Could not get rhythm value from string")
        }
    }
}
