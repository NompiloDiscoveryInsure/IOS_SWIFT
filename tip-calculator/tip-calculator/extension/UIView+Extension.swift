//
//  UIView+Extension.swift
//  tip-calculator
//
//  Created by Nompilo Moyo on 2023/11/10.
//

import UIKit

extension UIView{
    func addShadow(
        offset: CGSize,
        color: UIColor,
        radius: CGFloat,
        opacity: Float
    ){
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius  = radius
        layer.shadowOpacity =   opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor =   nil
        layer.backgroundColor = backgroundCGColor
    }
    
    func addCornerRadius(radius: CGFloat){
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
    
    func addRoundCorners(corners: CACornerMask, radius: CGFloat){
        layer.cornerRadius = radius
        layer.maskedCorners = [corners]
    }
}


