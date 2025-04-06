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
    
    let scoreText: String?
    let scoreColor: UIColor
    let dateText: String
    let timeText: String
    let timeColor: UIColor

    init(event: Event) {
        homeName = event.homeTeam.name
        awayName = event.awayTeam.name
        homeLogoUrl = event.homeTeam.logoUrl
        awayLogoUrl = event.awayTeam.logoUrl
        
        // Score
        if let home = event.homeScore, let away = event.awayScore {
            scoreText = "\(home) - \(away)"
        } else {
            scoreText = nil
        }
        
        let currentTimestamp = Date().timeIntervalSince1970
        let elapsedTime = currentTimestamp - TimeInterval(event.startTimestamp)
        let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        
        if event.status == .notStarted {
            timeText = EventDetailsViewModel.hourMinuteFormatter.string(from: date)
        } else if event.status == .halftime {
            timeText = "Half Time"
        } else if event.status == .finished {
            timeText = "Full Time"
        } else {
            let minutes = Int(elapsedTime / 60)
            timeText = "\(minutes)'"
        }
        
        timeColor = event.status == .inProgress ? .inProgress : .primaryText
        scoreColor = event.status == .inProgress ? .inProgress : .primaryText
        
        if event.status == .notStarted {
            dateText = EventDetailsViewModel.dateFormatter.string(from: date)}
        else {
            dateText = ""
        }
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy. \nHH:mm"
        return formatter
    }()
    
    private static let hourMinuteFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

}
