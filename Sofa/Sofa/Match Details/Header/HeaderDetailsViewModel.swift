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
        let countryName = event.league.country?.name ?? "Unknown Country"
        self.titleText = "\(sport.rawValue.capitalized), \(countryName), \(event.league.name)"
        self.logoUrl = event.league.logoUrl
    }
}

