//
//  APIClient.swift
//  Sofa
//
//  Created by Akademija on 05.04.2025..
//

import Foundation

struct APIClient {
    static func getEvents(sport: Sport? = nil) async throws -> [Event] {
        var components = URLComponents(string: "https://sofa-ios-academy-43194eec0621.herokuapp.com/events")

        if let sport = sport {
            components?.queryItems = [
                URLQueryItem(name: "sport", value: sport.rawValue)
            ]
        }

        guard let url = components?.url else {
            return []
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            return []
        }

        let events = try JSONDecoder().decode([Event].self, from: data)
        return events
    }
}

