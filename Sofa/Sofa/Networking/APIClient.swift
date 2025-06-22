//
//  APIClient.swift
//  Sofa
//
//  Created by Akademija on 05.04.2025..
//

import Foundation

enum APIClient {
    
    private static let baseURL = "https://sofa-ios-academy-43194eec0621.herokuapp.com"

    static func getEvents(sport: Sport? = nil) async throws -> [Event] {
        var queryItems: [URLQueryItem] = []
        if let sport = sport {
            queryItems.append(sport.asQueryItem)
        }
        return try await fetch(path: "/events", queryItems: queryItems)
    }

    static func getEvent(id: Int64) async throws -> Event {
        return try await fetch(path: "/events/\(id)")
    }

    static func getEventIncidents(eventId: Int64) async throws -> [Incident] {
        return try await fetch(path: "/events/\(eventId)/incidents")
    }

    static func getLeague(id: Int) async throws -> League {
        return try await fetch(path: "/leagues/\(id)")
    }

    static func getLeagueMatches(id: Int) async throws -> [Event] {
        return try await fetch(path: "/leagues/\(id)/matches")
    }

    static func getLeagueStandings(id: Int) async throws -> [Standings] {
        return try await fetch(path: "/leagues/\(id)/standings")
    }

    static func getTeam(id: Int) async throws -> TeamInfo {
        return try await fetch(path: "/teams/\(id)")
    }

    static func getTeamPlayers(id: Int) async throws -> [Player] {
        return try await fetch(path: "/teams/\(id)/players")
    }

    static func getTeamTournaments(id: Int) async throws -> [League] {
        return try await fetch(path: "/teams/\(id)/tournaments")
    }

    private static func fetch<T: Decodable>(path: String, queryItems: [URLQueryItem] = []) async throws -> T {
        var components = URLComponents(string: baseURL)
        components?.path = path
        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        if !path.contains("/login"), let token = TokenStorage.get() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension APIClient {
    static func login(username: String, password: String) async throws -> LoginResponse {
        guard let url = URL(string: "\(baseURL)/login") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = LoginRequest(username: username, password: password)
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(LoginResponse.self, from: data)
    }
}
