//
//  StandingsViewModel.swift
//  Sofa
//
//  Created by Akademija on 12.06.2025..
//

struct StandingViewModel {
    
    let team: Team
    
    let standingText: String
    let teamName: String

    let matches: String
    let wins: String
    let losses: String
    let draws: String
    let goalDiff: String
    let points: String
    let diff: String
    let pct: String

    let columns: [StandingColumn]

    init(standings: Standings, sport: Sport) {
        self.team = standings.team
        self.standingText = "\(standings.position)"
        self.teamName = standings.team.name
        
        self.matches = "\(standings.matches)"
        self.wins = "\(standings.wins)"
        self.losses = "\(standings.losses)"
        self.draws = "\(standings.draws)"
        self.diff = standings.scoreFormatted
        self.points = "\(standings.points ?? 0)"
        self.goalDiff = "\(standings.scoreFor):\(standings.scoreAgainst)"
        self.pct = String(format: "%.3f", standings.percentage ?? 0.0)

        switch sport {
        case .football:
            self.columns = [
                StandingColumn(title: "P", width: 20, keyPath: \.matches),
                StandingColumn(title: "W", width: 20, keyPath: \.wins),
                StandingColumn(title: "D", width: 20, keyPath: \.draws),
                StandingColumn(title: "L", width: 20, keyPath: \.losses),
                StandingColumn(title: "Goals", width: 40, keyPath: \.goalDiff),
                StandingColumn(title: "Pts", width: 20, keyPath: \.points)
            ]
        case .basketball:
            self.columns = [
                StandingColumn(title: "P", width: 30, keyPath: \.matches),
                StandingColumn(title: "W", width: 30, keyPath: \.wins),
                StandingColumn(title: "L", width: 30, keyPath: \.losses),
                StandingColumn(title: "DIFF", width: 30, keyPath: \.diff),
                StandingColumn(title: "PCT", width: 40, keyPath: \.pct)
            ]
        case .americanFootball:
            self.columns = [
                StandingColumn(title: "P", width: 30, keyPath: \.matches),
                StandingColumn(title: "W", width: 30, keyPath: \.wins),
                StandingColumn(title: "D", width: 30, keyPath: \.draws),
                StandingColumn(title: "L", width: 30, keyPath: \.losses),
                StandingColumn(title: "PCT", width: 40, keyPath: \.pct)
            ]
        }
    }
}
