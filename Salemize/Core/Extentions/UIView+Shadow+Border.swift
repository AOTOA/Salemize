//
//  UIView+Shadow+Border.swift
//  Salemize
//
//  Created by Ebrahim Tahernejad on 9/15/17.
//  Copyright © 2017 Ebi :). All rights reserved.
//

import UIKit

extension UIView {
    
    func setShadow(_ color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
    
    func setBorder(_ color: UIColor, width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
