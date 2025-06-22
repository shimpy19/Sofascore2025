//
//  Sports.swift
//  Sofa
//
//  Created by Akademija on 22.03.2025..
//

import Foundation

enum TeamDetails: CaseIterable {
    case details
    case squad

    var title: String {
        switch self {
        case .details:
            return "Details"
        case .squad:
            return "Squad"
        }
    }
}
