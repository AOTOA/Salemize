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
    func overlayStartSelected(type: OverlayViewValueType, value: Int)
}

class OverlayView: UIView, UITextFieldDelegate {
    
    var blurView: APCustomBlurView!
    var closeButton: UIButton!
    var typeTitle: UILabel!
    var valueTitle: UILabel!
    var segment: SMSegment!
    var value: UITextField!
    var startButton: UIButton!
    
    var delegate: OverlayViewDelegate?
    
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
        closeButton.setImage(UIImage.init(named: "close"), for: .normal)
        closeButton.frame = CGRect(x: 20, y: 35, width: 14, height: 14)
        closeButton.tag = 2
        closeButton.addTarget(self, action: #selector(buttonActions(_:)), for: .touchUpInside)
        
        segmentButtons = [
            OverlayViewValueType.callories.rawValue,
            OverlayViewValueType.time.rawValue,
            OverlayViewValueType.distance.rawValue
        ]
        segment = SMSegment(titles: segmentButtons)
        segment.disabled = true
        
        typeTitle = UILabel()
        typeTitle.font = SMFont.medium(14)
        typeTitle.textColor = SMColor(name: .overlayTitle)
        typeTitle.text = SMLocalized("SM.Map.Titles.Type")
        typeTitle.sizeToFit()
        
        valueTitle = UILabel()
        let valueString: NSMutableAttributedString = NSMutableAttributedString(string: SMLocalized("SM.Map.Titles.Value") + " ", attributes: [
            NSAttributedStringKey.foregroundColor: SMColor(name: .overlayTitle),
            NSAttributedStringKey.font: SMFont.medium(14)!
            ])
        valueString.append(NSMutableAttributedString(string: SMLocalized("SM.Map.Titles.Value.Unit"), attributes: [
            NSAttributedStringKey.foregroundColor: SMColor(name: .overlayTitle),
            NSAttributedStringKey.font: SMFont.medium(9)!
            ]))
        valueTitle.attributedText = valueString
        valueTitle.sizeToFit()
        
        value = UITextField.init()
        value.font = SMFont.medium(17)
        value.layer.cornerRadius = 4
        value.layer.borderColor = UIColor.init(hex: "7F8CA1").cgColor
        value.layer.borderWidth = 1
        value.textAlignment = .center
        value.backgroundColor = SMColor(name: .white, alpha: 0.4)
        value.keyboardType = .numberPad
        
        startButton = UIButton()
        startButton.frame.size.height = 50
        startButton.backgroundColor = SMColor(name: .endTaskColor)
        startButton.layer.cornerRadius = 8
        startButton.setAttributedTitle(NSAttributedString.init(string: SMLocalized("SM.Map.Titles.Submit"), attributes: [
            NSAttributedStringKey.foregroundColor: SMColor(name: .white),
            NSAttributedStringKey.font: SMFont.medium(16)!
            ]), for: .normal)
        startButton.tag = 1
        startButton.addTarget(self, action: #selector(buttonActions(_:)), for: .touchUpInside)
        startButton.isEnabled = false
        
        self.addSubview(blurView)
        self.addSubview(segment)
        self.addSubview(typeTitle)
        self.addSubview(valueTitle)
        self.addSubview(startButton)
        self.addSubview(closeButton)
        self.addSubview(value)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.blurView.frame = self.frame
        
        segment.center.x = self.center.x
        segment.frame.origin.y = 275.0 / 667 * self.frame.size.height
        segment.frame.size.height = 40
        segment.frame.size.width = 240.0 / 375 * self.frame.size.width
        
        startButton.frame.origin.y = self.frame.size.height - startButton.frame.size.height - 20
        startButton.frame.size.width = 235.0 / 375 * self.frame.size.width
        startButton.center.x = self.center.x
        
        typeTitle.frame.origin = CGPoint(x: self.frame.size.width - 22 - typeTitle.frame.size.width,
                                         y: 226.0 / 667 * self.frame.size.height)
        
        valueTitle.frame.origin = CGPoint(x: self.frame.size.width - 22 - valueTitle.frame.size.width,
                                          y: 357.0 / 667 * self.frame.size.height)
        
        value.center.x = self.center.x
        value.frame.origin.y = 406.0 / 667 * self.frame.size.height
        value.frame.size = segment.frame.size
        value.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.components(separatedBy: CharacterSet.decimalDigits).joined() == "" {
            let newText: String = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            if Int("0" + newText)! <= 20000 {
                if newText.replacingOccurrences(of: "0", with: "") != "" {
                    startButton.backgroundColor = SMColor(name: .startActionButton)
                } else {
                    startButton.backgroundColor = SMColor(name: .endTaskColor)
                }
                startButton.isEnabled = newText.replacingOccurrences(of: "0", with: "") != ""
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    @objc func buttonActions(_ sender: UIButton) {
        switch sender.tag {
        case 1: // start pressed
            if value.text != "" {
                self.delegate?.overlayStartSelected(type: OverlayViewValueType(rawValue: segmentButtons[segment.selectedIndex])!, value: Int(value.text!)!)
            }
            break
        case 2: // close
            self.delegate?.overlayCloseSelected()
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
}
