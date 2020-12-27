//
//  File.swift
//  task_4
//
//  Created by Aliona Starunska on 27.12.2020.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localization") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}

enum Localization {
    enum Buttons {
        static var giveDetails: String { return "buttons.give_me_details".localized() }
        static var checkStats: String { return "buttons.check_stats".localized() }
        static var done: String { return "buttons.done".localized() }
        static var ok: String { return "buttons.ok".localized() }
    }
    enum Homepage {
        static var beyoundLimits: String { return "homepage.beyound_limits".localized() }
        static var enterUsername: String { return "homepage.enter_username".localized() }
        static var error: String { return "homepage.error".localized() }
    }
    enum Detais {
        static var playerEnthusiast: String { return "details.player_enthusiast".localized() }
        static var date: String { return "details.date".localized() }
    }
    enum Stats {
        static var videos: String { return "stats.videos".localized() }
        static var hearts: String { return "stats.hearts".localized() }
        static var games: String { return "stats.games".localized() }
        static var wins: String { return "stats.wins".localized() }
    }
    enum Alert {
        static var title: String { return "alert.title".localized() }
        static var text: String { return "alert.text".localized() }
    }
}
