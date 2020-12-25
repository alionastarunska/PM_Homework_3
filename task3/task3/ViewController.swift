//
//  ViewController.swift
//  task3
//
//  Created by Aliona Starunska on 24.12.2020.
//

import UIKit

private enum Direction {
    case top
    case bottom
    case left
    case right
    case none
}

class ViewController: UIViewController {
    
    private weak var circle: UIView?
    private let colors: [UIColor] = [.systemYellow, .systemOrange, .systemRed, .systemBlue, .systemGreen, .systemPurple]
    private var originalPoint: CGPoint?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initializeCircle()
        centerCircle()
        setupActions()
    }
    
    // MARK: - Actions
    
    @objc private func panAction(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            originalPoint = sender.location(in: view)
        case .ended:
            guard let originalPoint = originalPoint else { break }
            let point = sender.location(in: view)
            let x = point.x - originalPoint.x
            let y = point.y - originalPoint.y
            var direction: Direction = .none
            if abs(x) > abs(y) {
                direction = x > 0 ? .right : .left
            } else {
                direction = y > 0 ? .bottom : .top
            }
            self.originalPoint = nil
            animateStep(direction)
        default: break
        }
    }
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        animateCenter()
    }
    
    @objc private func doubleTapAction(_ sender: UITapGestureRecognizer) {
        animateCenter {
            self.animateMoveCircle()
        }
    }
    
    // MARK: - Animations
    
    private func animateStep(_ direction: Direction) {
        guard let circle = circle else { return }
        view.isUserInteractionEnabled = false
        let frame = CGRect(origin: circle.frame.origin.appending(direction.stepOffset), size: circle.frame.size)
        let color = self.colors.filter({ !$0.equals(circle.backgroundColor ?? .clear) }).randomElement()
        UIView.animate(withDuration: .duration, animations: {
            circle.frame = frame
            circle.backgroundColor = color
        }, completion: { _ in
            self.view.isUserInteractionEnabled = true
        })
    }
    
    private func animateCenter(_ completion: (()->Void)? = nil) {
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: .duration, animations: {
            self.centerCircle()
        }, completion: { _ in
            self.view.isUserInteractionEnabled = true
            completion?()
        })
    }
    
    private func animateMoveCircle() {
        guard let circle = circle else { return }
        let path = UIBezierPath()
        let initialPoint = self.getPoint(for: -90)
        path.move(to: initialPoint)
        for angle in -89...0 { path.addLine(to: self.getPoint(for: angle)) }
        for angle in 1...270 { path.addLine(to: self.getPoint(for: angle)) }
        path.close()
        let animation = CAKeyframeAnimation(keyPath: .position)
        animation.path = path.cgPath
        animation.repeatCount = 1
        animation.duration = .duration * 2
        animation.delegate = self
        circle.layer.add(animation, forKey: .position)
    }
    
    // MARK: - Private
    
    private func centerCircle() {
        guard let circle = circle else { return }
        let x = (view.bounds.width - circle.bounds.width) / 2
        let y = (view.bounds.height - circle.bounds.height) / 2
        circle.frame = CGRect(origin: CGPoint(x: x, y: y), size: circle.frame.size)
    }
    
    private func initializeCircle() {
        let circle = UIView(frame: CGRect(x: 0, y: 0, width: .circleSize, height: .circleSize))
        circle.layer.cornerRadius = .circleSize / 2
        circle.backgroundColor = .systemRed
        circle.clipsToBounds = true
        view.addSubview(circle)
        self.circle = circle
    }
    
    private func setupActions() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction(_:)))
        doubleTap.numberOfTapsRequired = 2
        tap.require(toFail: doubleTap)
        [pan, tap, doubleTap].forEach({ view.addGestureRecognizer($0) })
    }
    
    private func getPoint(for angle: Int) -> CGPoint {
        let radians = angle.radians
        let newCenterX = view.center.x + .animationCircleRadius * cos(radians)
        let newCenterY = view.center.y + .animationCircleRadius + .animationCircleRadius * sin(radians)
        return CGPoint(x: newCenterX, y: newCenterY)
    }
}

// MARK: - CAAnimationDelegate

extension ViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        view.isUserInteractionEnabled = false
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        view.isUserInteractionEnabled = true
    }
}

// MARK: - Constants

private extension Direction {
    var stepOffset: CGPoint {
        switch self {
        case .bottom: return CGPoint(x: 0, y: .step)
        case .top: return CGPoint(x: 0, y: -.step)
        case .left: return CGPoint(x: -.step, y: 0)
        case .right: return CGPoint(x: .step, y: 0)
        default: return .zero
        }
    }
}

private extension CGPoint {
    func appending(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: x + point.x, y: y + point.y)
    }
}

private extension Int {
    var radians: CGFloat { return CGFloat(Double(self) * Double.pi / Double(180)) }
}

private extension CGFloat {
    static var circleSize: CGFloat { return 40.0 }
    static var step: CGFloat { return 30.0 }
    static var animationCircleRadius: CGFloat { return 80.0 }
}

private extension TimeInterval {
    static var duration: TimeInterval { return 1.5 }
}

private extension String {
    static var position: String { return "position"}
}

private extension UIColor {
    func equals(_ rhs: UIColor) -> Bool {
        var lhsR: CGFloat = 0
        var lhsG: CGFloat = 0
        var lhsB: CGFloat = 0
        var lhsA: CGFloat = 0
        self.getRed(&lhsR, green: &lhsG, blue: &lhsB, alpha: &lhsA)

        var rhsR: CGFloat = 0
        var rhsG: CGFloat = 0
        var rhsB: CGFloat = 0
        var rhsA: CGFloat = 0
        rhs.getRed(&rhsR, green: &rhsG, blue: &rhsB, alpha: &rhsA)

        return  lhsR == rhsR &&
                lhsG == rhsG &&
                lhsB == rhsB &&
                lhsA == rhsA
    }
}
