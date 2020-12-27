//
//  StatsViewController.swift
//  task_4
//
//  Created by Aliona Starunska on 26.12.2020.
//

import UIKit

struct Stats {
    var image: UIImage?
    var title: String
    var value: String
    
    init(image: UIImage?, title: String, value: String) {
        self.image = image
        self.title = title
        self.value = value
    }
}

class StatsViewController: UIViewController {

    private var stats: [Stats] = []
    
    @IBOutlet private weak var stat1ImageView: UIImageView!
    @IBOutlet private weak var stat1TitleLabel: UILabel!
    @IBOutlet private weak var stat1ValueLabel: UILabel!
    @IBOutlet private weak var stat2ImageView: UIImageView!
    @IBOutlet private weak var stat2TitleLabel: UILabel!
    @IBOutlet private weak var stat2ValueLabel: UILabel!
    @IBOutlet private weak var checkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTexts()
        drawStats()
    }
    
    // MARK: - Public
    
    func set(stats: [Stats]) {
        self.stats = stats
    }
    
    // MARK: - Private
    
    private func setupTexts() {
        checkButton.setTitle(Localization.Buttons.checkStats, for: [])
    }
    
    private func drawStats() {
        if let stat = stats.first {
            stat1ImageView.image = stat.image
            stat1TitleLabel.text = stat.title
            stat1ValueLabel.text = stat.value
        }
        if let stat = stats.last {
            stat2ImageView.image = stat.image
            stat2TitleLabel.text = stat.title
            stat2ValueLabel.text = stat.value
        }
    }
}

