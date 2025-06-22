//
//  Models.swift
//  Sofa
//
//  Created by Akademija on 05.04.2025..
//

import Foundation

struct Country: Codable {
    let name: String
}

struct Team: Codable {
    let id: Int
    let name: String
    let logoUrl: String
    let country: Country?
}

struct League: Codable {
    let id: Int
    let name: String
    let country: Country?
    let logoUrl: String
    let seasonId: Int64?
}

struct Event: Codable {
    let id: Int64
    let homeTeam: Team
    let awayTeam: Team
    let startTimestamp: Int64
    let status: EventStatus
    let league: League
    let homeScore: Int?
    let awayScore: Int?
    let round: Int
    let incidents: [Incident]?
}

enum EventStatus: String, Codable {
    case notStarted = "NOT_STARTED"
    case inProgress = "IN_PROGRESS"
    case halfTime = "HALF_TIME"
    case finished = "FINISHED"
}

struct Incident: Codable {
    let type: IncidentType
    let minute: Int?
    let isHomeTeam: Bool?
    let extraMinute: Int?
    let player: String?
    let scoreDiff: Int?
    let score: String?
    let description: String?
}

enum IncidentType: String, Codable {
    case goal = "GOAL"
    case redCard = "RED_CARD"
    case yellowCard = "YELLOW_CARD"
    case periodEnd = "PERIOD_END"
    case foul = "FOUL"
}

struct LoginRequest: Encodable {
    let username: String
    let password: String
}

struct LoginResponse: Decodable {
    let name: String
    let token: String
}

struct Standings: Codable {
    let team: Team
    let position: Int
    let matches: Int
    let wins: Int
    let losses: Int
    let draws: Int
    let points: Int?
    let percentage: Double?
    let scoreFor: Int
    let scoreAgainst: Int
    let scoreFormatted: String
}

struct TeamManager: Codable {
    let id: Int64
    let name: String
    let country: Country
    let imageUrl: String
}

struct TeamVenueCity: Codable {
    let name: String
}

struct TeamVenue: Codable {
    let name: String
    let capacity: Int
    let city: TeamVenueCity
}

struct TeamInfo: Codable {
    let team: Team
    let manager: TeamManager
    let venue: TeamVenue
}

struct Player: Codable {
    let id: Int64
    let name: String
    let shortName: String
    let position: String
    let jerseyNumber: String?
    let country: Country
    let imageUrl: String
    let isForeign: Bool
}

