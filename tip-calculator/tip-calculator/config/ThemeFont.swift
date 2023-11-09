//
//  ThemeFont.swift
//  tip-calculator
//
//  Created by Nompilo Moyo on 2023/11/09.
//

import UIKit

struct Themefont{
    //AvienirNext
    static func regular(ofSize size: CGFloat) -> UIFont{
        return UIFont(name: "AvenirNext-regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func bold(ofSize size: CGFloat) -> UIFont{
        return UIFont(name: "AvenirNext-Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func demibold(ofSize size: CGFloat) -> UIFont{
        return UIFont(name: "AvenirNext-DemiBold", size: size) ?? .systemFont(ofSize: size)
    }
}
