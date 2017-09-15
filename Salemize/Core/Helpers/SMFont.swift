//
//  ASFont.swift
//  AppStore
//
//  Created by Ebrahim Tahernejad on 9/8/17.
//  Copyright © 2017 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class ASFont {
    
    static func optimizeSize(_ size: CGFloat) -> CGFloat {
        /*let screenSize: CGFloat = UIScreen.main.bounds.size.width + UIScreen.main.bounds.size.height
         print(screenSize)
         if screenSize > 1042 {
         // iPhone Plus
         return size + 2
         } else if screenSize <= 888.0 {
         // iPhone SE/5
         return size - 1
         }*/
        return size
    }
    
    static func fontName(_ isSecondary: Bool) -> String {
        return isSecondary ? "iranyekan" : "IRANSansMobile"
        return "Helvetica-Neue"
    }
    
    static func bold(_ size: CGFloat, isSecondary: Bool = false) -> UIFont? {
        return UIFont(name: "\(fontName(isSecondary))-Bold", size: optimizeSize(size))
    }
    
    static func regular(_ size: CGFloat, isSecondary: Bool = false) -> UIFont? {
        return UIFont(name: "\(fontName(isSecondary))", size: optimizeSize(size))
    }
    
    static func medium(_ size: CGFloat, isSecondary: Bool = false) -> UIFont? {
        return UIFont(name: "\(fontName(isSecondary))-Medium", size: optimizeSize(size))
    }
    
    static func light(_ size: CGFloat, isSecondary: Bool = false) -> UIFont? {
        return UIFont(name: "\(fontName(isSecondary))-Light", size: optimizeSize(size))
    }
    
    static func ultraLight(_ size: CGFloat, isSecondary: Bool = false) -> UIFont? {
        return UIFont(name: "\(fontName(isSecondary))-UltraLight", size: optimizeSize(size))
    }
    
}


