//
//  Models.swift
//  Sofa
//
//  Created by Akademija on 05.04.2025..
//

import Foundation

struct Team: Decodable {
    let id: Int
    let name: String
    let logoUrl: String
}

struct Country: Decodable {
    let id: Int
    let name: String
}

struct League: Decodable {
    let id: Int
    let name: String
    let country: Country
    let logoUrl: String
}

struct Event: Decodable {
    let id: Int
    let homeTeam: Team
    let awayTeam: Team
    let startTimestamp: Int64
    let league: League
    let homeScore: Int?
    let awayScore: Int?
    let status: EventStatus?
}

public enum EventStatus: String, Decodable {
    case notStarted = "NOT_STARTED"
    case inProgress = "IN_PROGRESS"
    case halftime = "HALFTIME"
    case finished = "FINISHED"
}

struct LoginRequest: Encodable {
    let username: String
    let password: String
}

struct LoginResponse: Decodable {
    let name: String
    let token: String
}

