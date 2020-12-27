//
//  DetailsViewController.swift
//  task_4
//
//  Created by Aliona Starunska on 26.12.2020.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var playerRoleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    private var userName: String?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = userName
        setupTexts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarImageView.round()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? StatsViewController else { return }
        var stats: [Stats] = []
        switch segue.identifier ?? "" {
        case .first:
            stats = [Stats(image: .video, title: Localization.Stats.videos, value: "\(arc4random_uniform(1000))"),
                     Stats(image: .heart, title: Localization.Stats.hearts, value: "\(arc4random_uniform(10000))")]
        case .second:
            stats = [Stats(image: .game, title: Localization.Stats.games, value: "\(arc4random_uniform(1000))"),
                     Stats(image: .win, title: Localization.Stats.wins, value: "\(arc4random_uniform(1000))")]
        default: break
        }
        viewController.set(stats: stats)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        avatarImageView.round(animated: true)
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            self?.avatarImageView.round(animated: true)
        }
    }
    
    // MARK: - Public
    
    func set(userName: String) {
        self.userName = userName
    }
    
    // MARK: - Private
    
    private func setupTexts() {
        doneButton.setTitle(Localization.Buttons.done, for: [])
        playerRoleLabel.text = Localization.Detais.playerEnthusiast
    }
    
    @IBAction private func doneAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

private extension UIImage {
    static var video: UIImage? { return UIImage(named: "video-icon") }
    static var game: UIImage? { return UIImage(named: "game-icon") }
    static var win: UIImage? { return UIImage(named: "win-icon") }
    static var info: UIImage? { return UIImage(named: "info-icon") }
    static var heart: UIImage? { return UIImage(named: "heart-icon") }
}

private extension String {
    static var first: String { return "first" }
    static var second: String { return "second" }
}
