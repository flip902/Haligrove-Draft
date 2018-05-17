//
//  Extensions.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-04-05.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

// MARK: - anchor extension
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingRight: CGFloat, paddingBottom: CGFloat, paddingLeft: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

// MARK: - color extension
extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) ->
        UIColor {
            return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
