//
//  UIView+IBInspectable.swift
//  task_2
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
    
    func round(animated: Bool = false) {
        if animated {
            let corners = CABasicAnimation(keyPath: "cornerRadius")
            corners.fromValue = cornerRadius
            corners.toValue = min(frame.size.width, frame.size.height) / 2
            corners.repeatCount = 1
            corners.autoreverses = false
            corners.isRemovedOnCompletion = false
            corners.timingFunction = CAMediaTimingFunction(name: .easeIn)
            corners.duration = 0.1
            layer.add(corners, forKey: nil)
            cornerRadius = min(frame.width, frame.height) / 2
        } else {
            cornerRadius = min(frame.width, frame.height) / 2
        }
    }
}

private extension CGColor {
    
    var uiColor: UIKit.UIColor {
        return UIKit.UIColor(cgColor: self)
    }
}

