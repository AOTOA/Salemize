//
//  SMSegment.swift
//  Salemize
//
//  Created by Ebrahim Tahernejad on 9/15/17.
//  Copyright © 2017 Ebi :). All rights reserved.
//

import UIKit

class SMSegment: UIView {

    private var selectedIndex: Int = 0
    private var buttonsArray: Array<UIButton> = []
    var disabled: Bool = false
    
    init(titles: Array<String>) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        
        for i in 0..<titles.count {
            let button = UIButton()
            button.tag = i
            button.addTarget(self, action: #selector(ButtonPressed(_:)), for: .touchUpInside)
            button.setTitle(SMLocalized(titles[i]), for: .normal)
            button.setTitleColor(SMColor(name: .black), for: .normal)
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.font = SMFont.medium(14)
            buttonsArray.append(button)
            
            self.addSubview(button)
        }
        self.selectedIndex = buttonsArray.count - 1
        
        buttonsArray[selectedIndex].backgroundColor = SMColor(name: .selectedSegment)
        buttonsArray[selectedIndex].setTitleColor(SMColor(name: .white), for: .normal)
        
        self.layer.cornerRadius = 4
        self.layer.borderColor = SMColor(name: .selectedSegment).cgColor
        self.layer.borderWidth = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var i: Int = 0
        for button in buttonsArray {
            button.frame.size.height = self.frame.size.height
            button.frame.size.width = self.frame.size.width / CGFloat(buttonsArray.count)
            button.frame.origin.x = button.frame.size.width * CGFloat(i)
            button.frame.origin.y = 0
            i += 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func ButtonPressed(_ button: UIButton) {
        if !disabled {
            for i in 0..<buttonsArray.count {
                if button.tag != i {
                    buttonsArray[i].backgroundColor = UIColor.clear
                    buttonsArray[i].setTitleColor(SMColor(name: .black), for: .normal)
                }
            }
            
            if button.tag != selectedIndex {
                selectedIndex = button.tag
                buttonsArray[button.tag].backgroundColor = SMColor(name: .selectedSegment)
                buttonsArray[button.tag].setTitleColor(SMColor(name: .white), for: .normal)
            }
        }
    }

}
