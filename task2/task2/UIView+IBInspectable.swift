//
//  UIView+IBInspectable.swift
//  task2
//
//  Created by Aliona Starunska on 24.12.2020.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
