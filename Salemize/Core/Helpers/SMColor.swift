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
    case overlayTitle = "#5A5A5A"
    case startActionButton = "#1A73CA"
    case separatorColor = "#4C4F73"
    case gray = "#A2A2A2"
    case endTaskColor = "#999999"
    case storeSeparator = "#F1F1F1"
}

func SMColor(name: SMColorHex, alpha: CGFloat = 1.0) -> UIColor {
    return UIColor(hex: name.rawValue, alpha: alpha)
}
