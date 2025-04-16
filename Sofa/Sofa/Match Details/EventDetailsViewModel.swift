//
//  EventDetailsViewModel.swift
//  Sofa
//
//  Created by Akademija on 05.04.2025..
//

import Foundation
import UIKit
import SofaAcademic

struct EventDetailsViewModel {
    let homeName: String
    let awayName: String
    let homeLogoUrl: String?
    let awayLogoUrl: String?
    let homeScoreColor: UIColor
    let awayScoreColor: UIColor
    let homeScoreText: String?
    let awayScoreText: String?
    
    let scoreDividerText: String?
    let scoreDividerColor: UIColor
    
    let dateText: String
    let timeText: String
    let timeColor: UIColor

    init(event: Event) {
        homeName = event.homeTeam.name
        awayName = event.awayTeam.name
        homeLogoUrl = event.homeTeam.logoUrl
        awayLogoUrl = event.awayTeam.logoUrl
        homeScoreText = event.homeScore.map { "\($0)" }
        awayScoreText = event.awayScore.map { "\($0)" }

        timeText = EventDetailsViewModel.makeTimeText(for: event)
        dateText = EventDetailsViewModel.makeDateText(for: event)
        timeColor = event.status == .inProgress ? .inProgress : .primaryText

        let colors = EventDetailsViewModel.scoreColors(for: event)
        homeScoreColor = colors.home
        awayScoreColor = colors.away
        
        let scoreDivider = EventDetailsViewModel.makeScoreDividerColorAndText(for: event)
        scoreDividerText = scoreDivider.text
        scoreDividerColor = scoreDivider.color
    }

    private static func makeTimeText(for event: Event) -> String {
        let currentTimestamp = Date().timeIntervalSince1970
        let elapsedTime = currentTimestamp - TimeInterval(event.startTimestamp)
        let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))

        switch event.status {
        case .notStarted:
            return date.hourMinute
        case .halftime:
            return "Half Time"
        case .finished:
            return "Full Time"
        case .inProgress:
            let minutes = Int(elapsedTime / 60)
            return "\(minutes)'"
        default:
            return ""
        }
    }

    private static func makeDateText(for event: Event) -> String {
        guard event.status == .notStarted else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        return date.dayMonthYearTime
    }
    private static func scoreColors(for event: Event) -> (home: UIColor, away: UIColor) {
        guard let home = event.homeScore, let away = event.awayScore else {
            return (.primaryText, .primaryText)
        }

        guard event.status == .finished else {
            return (.inProgress, .inProgress)
        }

        if home > away {
            return (.primaryText, .secondaryText)
        } else if away > home {
            return (.secondaryText, .primaryText)
        } else {
            return (.primaryText, .primaryText)
        }
    }
    private static func makeScoreDividerColorAndText(for event: Event) -> (color:UIColor, text: String?) {
        if event.status == .notStarted {
            return (.primaryText, nil)
        } else if event.status == .inProgress {
            return (.inProgress, "-")
        } else {
            return (.primaryText, "-")
        }
    }
}
