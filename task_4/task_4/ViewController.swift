//
//  ViewController.swift
//  task_4
//
//  Created by Aliona Starunska on 25.12.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var detailsButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTexts()
    }
    
    // MARK: - Private
    
    private func setupTexts() {
        titleLabel.text = Localization.Homepage.beyoundLimits
        usernameTextField.placeholder = Localization.Homepage.enterUsername
        detailsButton.setTitle(Localization.Buttons.giveDetails, for: [])
        errorLabel.text = Localization.Homepage.error
    }
    
    @IBAction private func detailsAction(_ sender: Any) {
        guard let username = usernameTextField.text, !username.isEmpty else {
            errorLabel.isHidden = false
            return
        }
        errorLabel.isHidden = true
        
        guard let detailsViewController: DetailsViewController = storyboard?.get() else { return }
        detailsViewController.set(userName: username)
        present(detailsViewController, animated: true, completion: nil)
    }
}

// MARK: - TextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
