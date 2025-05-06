//
//  StorageManager.swift
//  Sofa
//
//  Created by Akademija on 30.04.2025..
//


final class StorageManager {
    static let shared = StorageManager()
    private let db = DatabaseManager.shared

    func saveEvents(_ events: [Event]) {
        for event in events {
            let league = LeagueObject()
            league.id = event.league.id
            league.name = event.league.name
            league.country = event.league.country.name
            league.logoUrl = event.league.logoUrl
            db.save(league)

            let eventObj = EventObject()
            eventObj.id = event.id
            eventObj.startTimestamp = event.startTimestamp
            eventObj.homeTeamName = event.homeTeam.name
            eventObj.awayTeamName = event.awayTeam.name
            eventObj.homeScore = event.homeScore
            eventObj.awayScore = event.awayScore
            eventObj.league = league

            db.save(eventObj)
        }
    }

    func countEvents() -> Int {
        db.getAll(ofType: EventObject.self).count
    }

    func countLeagues() -> Int {
        db.getAll(ofType: LeagueObject.self).count
    }

    func deleteAll() {
        db.deleteAll()
    }
}



