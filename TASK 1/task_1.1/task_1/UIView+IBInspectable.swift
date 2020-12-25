//
//  UIView+IBInspectable.swift
//  task_1
//
//  Created by Aliona Starunska on 24.12.2020.
//

import UIKit

extension UIView {
    // MARK: - IBInspectable
        
        @IBInspectable var cornerRadius: CGFloat {
            set {
                layer.cornerRadius = newValue
            }
            get {
                return layer.cornerRadius
            }
        }
        
        @IBInspectable var borderWidth: CGFloat {
            set {
                layer.borderWidth = newValue
            }
            get {
                return layer.borderWidth
            }
        }
        
        @IBInspectable var borderColor: UIColor? {
            set {
                layer.borderColor = newValue?.cgColor
            }
            get {
                return layer.borderColor?.uiColor
            }
        }
}

private extension CGColor {
    
    var uiColor: UIKit.UIColor {
        return UIKit.UIColor(cgColor: self)
    }
}
