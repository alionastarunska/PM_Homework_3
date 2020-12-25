//
//  ViewController.swift
//  task2
//
//  Created by Aliona Starunska on 24.12.2020.
//

    import UIKit

    class ViewController: UIViewController {

        @IBOutlet private weak var viewToTransform: UIView!
        @IBOutlet private weak var squareViewToRecolor: UIView!
        @IBOutlet private weak var circleViewToRecolor: UIView!
        @IBOutlet private weak var viewToRotate: UIView!
        @IBOutlet private weak var viewToChangeCornerRadius: UIView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupAnimations()
        }
        
        private func setupAnimations() {
            setupTransform()
            setupRecolor()
            setupRotate()
            setupCorners()
        }
        
        // MARK: - Animations
        
        private func setupTransform() {
            let transform = CABasicAnimation(keyPath: .transform)
            transform.duration = .durationTransform
            transform.fromValue = CGFloat.one
            transform.toValue = CGFloat.transform
            transform.autoreverses = true
            transform.repeatCount = .infinity
            viewToTransform.layer.add(transform, forKey: .transform)
        }
        
        private func setupRecolor() {
            [squareViewToRecolor, circleViewToRecolor].forEach {
                let color = UIColor.random
                let animation = makeRecolorAnimation(from: $0?.backgroundColor ?? .clear, to: color)
                if $0 == circleViewToRecolor { animation.delegate = self }
                $0?.layer.add(animation, forKey: .recolor)
                $0?.backgroundColor = color
            }
        }
        
        private func setupRotate() {
            let rotate = CABasicAnimation(keyPath: .rotation)
            rotate.duration = .durationRotate
            rotate.fromValue = -10.radians
            rotate.toValue = 190.radians
            rotate.isRemovedOnCompletion = false
            rotate.autoreverses = true
            rotate.repeatCount = .infinity
            rotate.fillMode = .forwards
            rotate.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            viewToRotate.layer.add(rotate, forKey: .rotation)
        }
        
        private func setupCorners() {
            let corners = CABasicAnimation(keyPath: .corners)
            corners.fromValue = viewToChangeCornerRadius.frame.size.width / 2
            corners.toValue = 0
            corners.repeatCount = .infinity
            corners.autoreverses = true
            corners.timingFunction = CAMediaTimingFunction(name: .easeIn)
            corners.duration = .durationCorners
            viewToChangeCornerRadius.layer.add(corners, forKey: .corners)
        }

        // MARK: - Recolor Animation Object
        
        private func makeRecolorAnimation(from: UIColor, to: UIColor = UIColor.random) -> CABasicAnimation {
            let recolor = CABasicAnimation(keyPath: .recolor)
            recolor.fromValue = from.cgColor
            recolor.toValue = to.cgColor
            recolor.duration = .durationRecolor
            recolor.autoreverses = false
            recolor.fillMode = .both
            recolor.isRemovedOnCompletion = false
            recolor.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            return recolor
        }
    }

    // MARK: - CAAnimationDelegate

    extension ViewController: CAAnimationDelegate {
        func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
            setupRecolor()
        }
    }

    // MARK: - Constants

    private extension CGFloat {
        static var one: CGFloat { return 1.0 }
        static var transform: CGFloat { return 1.5 }
    }

    private extension Int {
        var radians: CGFloat { return CGFloat(Double(self) * Double.pi / Double(180)) }
    }

    private extension TimeInterval {
        static var durationTransform: TimeInterval { return 1.3 }
        static var durationRecolor: TimeInterval { return 0.6 }
        static var durationCorners: TimeInterval { return 2 }
        static var durationRotate: TimeInterval { return 1 }
    }

    private extension String {
        static var transform: String { return "transform.scale" }
        static var recolor: String { return "backgroundColor" }
        static var rotation: String { return "transform.rotation.z" }
        static var corners: String { return "cornerRadius" }
    }

    private extension UIColor {
        static var random: UIColor {
            return UIColor(red: CGFloat(arc4random_uniform(255)) / 255,
                           green: CGFloat(arc4random_uniform(255)) / 255,
                           blue: CGFloat(arc4random_uniform(255)) / 255,
                           alpha: 1)
        }
    }

