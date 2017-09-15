//
//  OverlayView.swift
//  Salemize
//
//  Created by Ebrahim Tahernejad on 9/15/17.
//  Copyright © 2017 Ebi :). All rights reserved.
//

import UIKit

enum OverlayViewValueType: String {
    case distance = "SM.Map.Types.Distance"
    case time = "SM.Map.Types.Time"
    case callories = "SM.Map.Types.Callories"
}

protocol OverlayViewDelegate {
    func overlayCloseSelected()
    func overlayStartSelected()
}

class OverlayView: UIView {
    
    var blurView: APCustomBlurView!
    var closeButton: UIButton!
    var typeTitle: UILabel!
    var valueTitle: UILabel!
    var segment: SMSegment!
    var value: UITextField!
    var startButton: UIButton!
    
    var segmentButtons: [String]!
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        blurView = APCustomBlurView(withRadius: 5)
        
        closeButton = UIButton()
        
        segmentButtons = [
            OverlayViewValueType.callories.rawValue,
            OverlayViewValueType.time.rawValue,
            OverlayViewValueType.distance.rawValue
        ]
        segment = SMSegment(titles: segmentButtons)
        segment.disabled = true
        
        typeTitle = UILabel()
        
        valueTitle = UILabel()
        
        value = UITextField()
        
        startButton = UIButton(type: .system)
        
        self.addSubview(blurView)
        self.addSubview(segment)
        self.addSubview(typeTitle)
        self.addSubview(valueTitle)
        self.addSubview(startButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.blurView.frame = self.frame
        segment.frame = CGRect(x: 68, y: 275, width: 240, height: 40)
    }
}
