//
//  TimeBarViewModel.swift
//  Sofa
//
//  Created by Akademija on 20.06.2025..
//

import Foundation
import UIKit

struct TimeBarViewModel {
    let timeText: String
    let tintColor: UIColor

    init(event: Event) {
        switch event.status {
        case .notStarted:
            self.timeText = "Not Started"
            self.tintColor = .primaryText
        case .inProgress:
            self.timeText = "In Progress (\(event.homeScore ?? 0) - \(event.awayScore ?? 0))"
            self.tintColor = .sofaBlue
        case .halfTime:
            self.timeText = "HT (\(event.homeScore ?? 0) - \(event.awayScore ?? 0))"
            self.tintColor = .primaryText
        case .finished:
            self.timeText = "FT (\(event.homeScore ?? 0) - \(event.awayScore ?? 0))"
            self.tintColor = .primaryText
        }
    }
}
