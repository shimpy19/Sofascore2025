//
//  Sports.swift
//  Sofa
//
//  Created by Akademija on 22.03.2025..
//

import Foundation

enum LeagueDetails: CaseIterable {
    case matches
    case standings

    var title: String {
        switch self {
        case .matches:
            return "Matches"
        case .standings:
            return "Standings"
        }
    }
}
