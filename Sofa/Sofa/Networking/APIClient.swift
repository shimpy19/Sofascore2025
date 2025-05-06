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
        return try await fetch(path: "/secure/events", queryItems: queryItems)
    }
    
    private static func fetch<T: Decodable>(path: String, queryItems: [URLQueryItem] = []) async throws -> T {
        var components = URLComponents(string: baseURL)
        components?.path = path
        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        if path.contains("/secure/"), let token = TokenStorage.get() {
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
