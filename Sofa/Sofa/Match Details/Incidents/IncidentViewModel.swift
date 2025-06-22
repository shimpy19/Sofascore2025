//
//  IncidentViewModel.swift
//  Sofa
//
//  Created by Akademija on 20.06.2025..
//
import UIKit

struct IncidentViewModel {
    let iconName: String
    let tintColor: UIColor
    let minuteText: String
    let player: String
    let description: String
    let score: String?

    init(incident: Incident) {
        switch incident.type {
        case .goal:
            self.iconName = "ic_footballGreen"
            self.tintColor = .inProgress
        case .yellowCard:
            self.iconName = "ic_yellowcard"
            self.tintColor = .yellow
        case .redCard:
            self.iconName = "ic_yellowcard"
            self.tintColor = .red
        case .foul:
            self.iconName = "ic_yellowcard"
            self.tintColor = .sofaBlue
        default:
            self.iconName = "nothing"
            self.tintColor = .primaryText
        }

        self.minuteText = "\(incident.minute ?? 0)'"
        self.player = incident.player ?? "-"
        self.description = incident.description ?? ""
        self.score = incident.score
    }
}

