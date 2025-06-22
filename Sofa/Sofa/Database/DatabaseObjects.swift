//
//  DatabaseObjects.swift
//  Sofa
//
//  Created by Akademija on 16.04.2025..
//

import RealmSwift

class LeagueObject: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var country: String
    @Persisted var logoUrl: String
}

class EventObject: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var homeTeamName: String
    @Persisted var awayTeamName: String
    @Persisted var startTimestamp: Int64
    @Persisted var homeScore: Int?
    @Persisted var awayScore: Int?
    @Persisted var league: LeagueObject?
}

class PlayerObject: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var isForeign: Bool
    @Persisted var teamId: Int
}


