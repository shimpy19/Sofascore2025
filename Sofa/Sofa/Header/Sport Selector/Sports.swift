//
//  Sports.swift
//  Sofa
//
//  Created by Akademija on 22.03.2025..
//

import Foundation

enum Sport: String, CaseIterable {
    case football = "football"
    case basketball = "basketball"
    case americanFootball = "am-football"

    var title: String {
        switch self {
        case .football:
            return "Football"
        case .basketball:
            return "Basketball"
        case .americanFootball:
            return "Am. Football"
        }
    }

    var iconName: String {
        switch self {
        case .football:
            return "ic_football"
        case .basketball:
            return "ic_basketball"
        case .americanFootball:
            return "ic_amfootball"
        }
    }
}
