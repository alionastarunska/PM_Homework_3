//
//  PopupViewController.swift
//  task_4
//
//  Created by Aliona Starunska on 27.12.2020.
//

import UIKit

class PopupViewController: UIViewController {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTexts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: .duration,
                       delay: 0,
                       usingSpringWithDamping: .damping,
                       initialSpringVelocity: .velocity,
                       options: .curveEaseOut,
                       animations: {
                        self.contentView.transform = .identity
                       }, completion: nil)
    }
    
    // MARK: - Private
    
    private func setupTexts() {
        titleLabel.text = Localization.Alert.title
        textLabel.text = Localization.Alert.text
        okButton.setTitle(Localization.Buttons.ok, for: [])
    }
    
    @IBAction private func okAction(_ sender: UIButton) {
        UIView.animate(withDuration: .duration,
                       delay: 0,
                       usingSpringWithDamping: .damping,
                       initialSpringVelocity: .velocity,
                       options: .curveEaseOut,
                       animations: {
                        self.contentView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
                       }, completion: { _ in
                        self.dismiss(animated: true, completion: nil)
                       })
    }
}

private extension TimeInterval {
    static var duration: TimeInterval { return 0.5 }
}

private extension CGFloat {
    static var damping: CGFloat { return 0.7 }
    static var velocity: CGFloat { return 0.7 }
    
}
