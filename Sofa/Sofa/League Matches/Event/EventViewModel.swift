//
//  EventViewModel.swift
//  Sofa
//
//  Created by Akademija on 18.03.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class EventViewModel {
    let event: Event

    init(event: Event) {
        self.event = event
    }

    private var currentTimestamp: TimeInterval {
        return Date().timeIntervalSince1970
    }

    private var elapsedTime: TimeInterval {
        return currentTimestamp - TimeInterval(event.startTimestamp)
    }

    var timeText: String {
        if event.status == .notStarted {
            return "-"
        } else if event.status == .halfTime {
            return "HT"
        } else if event.status == .finished {
            return "FT"
        } else {
            let minutes = Int(elapsedTime / 60)
            return "\(minutes)'"
        }
    }

    var timeColor: UIColor {
        if event.status == .inProgress {
            return .inProgress
        } else {
            return .secondaryText
        }
    }

    var formattedStartTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startDate = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        return formatter.string(from: startDate)
    }

    var homeTeamViewModel: EventTeamViewModel {
        EventTeamViewModel(
            name: event.homeTeam.name,
            logoUrl: event.homeTeam.logoUrl,
            score: event.homeScore.map { "\($0)" } ?? " ",
            scoreColor: event.status == .inProgress ? .inProgress : .secondaryText
        )
    }

    var awayTeamViewModel: EventTeamViewModel {
        EventTeamViewModel(
            name: event.awayTeam.name,
            logoUrl: event.awayTeam.logoUrl,
            score: event.awayScore.map { "\($0)" } ?? " ",
            scoreColor: event.status == .inProgress ? .inProgress : .secondaryText
        )
    }
}

