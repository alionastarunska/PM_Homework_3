//
//  ViewController.swift
//  task_1.2
//
//  Created by Aliona Starunska on 24.12.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var portraitConstrains: [NSLayoutConstraint]!
    @IBOutlet var landscapeConstrains: [NSLayoutConstraint]!

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
            if UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
                let isLandscape = UIDevice.current.orientation.isLandscape
                portraitConstrains.forEach({ $0.priority = isLandscape ? .defaultLow : .defaultHigh })
                landscapeConstrains.forEach({ $0.priority = isLandscape ? .defaultHigh : .defaultLow })
                view.layoutIfNeeded()
            }
        }

}

