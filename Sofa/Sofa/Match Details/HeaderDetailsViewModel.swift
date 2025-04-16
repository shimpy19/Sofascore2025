//
//  HeaderDetailsViewModel.swift
//  Sofa
//
//  Created by Akademija on 11.04.2025..
//

import Foundation

struct HeaderDetailsViewModel {
    let titleText: String
    let logoUrl: String?

    init(event: Event, sport: Sport) {
        self.titleText = "\(sport.rawValue.capitalized), \(event.league.country.name), \(event.league.name)"
        self.logoUrl = event.league.logoUrl
    }
}

