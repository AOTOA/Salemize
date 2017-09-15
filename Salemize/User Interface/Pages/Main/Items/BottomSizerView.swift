//
//  BottomSizerView.swift
//  Salemize
//
//  Created by Ebrahim Tahernejad on 9/15/17.
//  Copyright © 2017 Ebi :). All rights reserved.
//

import UIKit

class BottomSizerView: UIView {

    func setButtons(_ buttons: [UIView]){
        for view in buttons {
            self.addSubview(view)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.subviews.count > 0 {
            let itemCenter: CGFloat = subviews[0].frame.size.width / 2
            let centersWidth: CGFloat = self.frame.size.width - (itemCenter * 2)
            let distance: CGFloat = centersWidth / CGFloat(self.subviews.count - 1)
            var currentX: CGFloat = itemCenter
            for subview in self.subviews {
                subview.center = CGPoint(x: currentX, y: self.frame.size.height / 2)
                currentX += distance
            }
        }
    }

}
