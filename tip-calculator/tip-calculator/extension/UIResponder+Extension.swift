//
//  UIResponder+Extension.swift
//  tip-calculator
//
//  Created by Nompilo Moyo on 2023/11/14.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}

