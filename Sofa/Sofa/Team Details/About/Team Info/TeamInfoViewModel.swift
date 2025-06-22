//
//  TeamInfoViewModel.swift
//  Sofa
//
//  Created by Akademija on 20.06.2025..
//

import UIKit
import SofaAcademic

struct TeamInfoViewModel {
    let coachImageUrl: String?
    let coachName: String
    let coachCountry: String
    let totalPlayers: String
    let foreignPlayers: String
    let progress: CGFloat

    init(teamInfo: TeamInfo) {
        let teamId = teamInfo.team.id
        let (total, foreign) = StorageManager.shared.countPlayers(forTeamId: teamId)
        
        self.coachImageUrl = teamInfo.manager.imageUrl
        self.coachName = "Coach: \(teamInfo.manager.name)"
        self.coachCountry = teamInfo.manager.country.name
        self.totalPlayers = "\(total)"
        self.foreignPlayers = "\(foreign)"
        self.progress = total == 0 ? 0 : CGFloat(foreign) / CGFloat(total)
    }
}

