//
//  DatabaseManager.swift
//  Sofa
//
//  Created by Akademija on 16.04.2025..
//

import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let realm: Realm

    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Realm init failed: \(error)")
        }
    }

    func save(events: [Event]) {
        do {
            try realm.write {
                for event in events {
                    if realm.object(ofType: EventObject.self, forPrimaryKey: event.id) == nil {
                        let league = LeagueObject()
                        league.id = event.league.id
                        league.name = event.league.name
                        league.country = event.league.country.name
                        league.logoUrl = event.league.logoUrl

                        // Save league if not already saved
                        if realm.object(ofType: LeagueObject.self, forPrimaryKey: league.id) == nil {
                            realm.add(league)
                        }

                        let eventObj = EventObject()
                        eventObj.id = event.id
                        eventObj.startTimestamp = event.startTimestamp
                        eventObj.homeTeamName = event.homeTeam.name
                        eventObj.awayTeamName = event.awayTeam.name
                        eventObj.homeScore = event.homeScore ?? 0
                        eventObj.awayScore = event.awayScore ?? 0
                        eventObj.league = league

                        realm.add(eventObj)
                    }
                }
            }
        } catch {
            print("Failed to save events: \(error)")
        }
    }

    func countEvents() -> Int {
        realm.objects(EventObject.self).count
    }

    func countLeagues() -> Int {
        realm.objects(LeagueObject.self).count
    }

    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Failed to delete Realm data: \(error)")
        }
    }
}
