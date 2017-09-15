//
//  SMColor.swift
//  Salemize
//
//  Created by Ebrahim Tahernejad on 9/15/17.
//  Copyright © 2017 Ebi :). All rights reserved.
//

import UIKit

enum SMColorHex: String {
    case mainPageGradientTop = "#FE2F8A"
    case mainPageGradientBottom = "#FCC267"
    case black = "#000000"
    case selectedSegment = "#2D333D"
    case white = "#ffffff"
}

func SMColor(name: SMColorHex, alpha: CGFloat = 1.0) -> UIColor {
    return UIColor(hex: name.rawValue, alpha: alpha)
}
