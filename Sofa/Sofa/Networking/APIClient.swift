//
//  APIClient.swift
//  Sofa
//
//  Created by Akademija on 05.04.2025..
//

import Foundation

struct APIClient {
    
    // Generička metoda za sve GET requestove
    static func performRequest<T: Decodable>(
        url: URL,
        method: String = "GET"
    ) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

    // Dohvat evenata s opcionalnim sport filterom
    static func getEvents(sport: Sport? = nil) async throws -> [Event] {
        var components = URLComponents(string: "https://sofa-ios-academy-43194eec0621.herokuapp.com/events")

        if let sport = sport {
            components?.queryItems = [
                URLQueryItem(name: "sport", value: sport.queryValue)
            ]
        }

        guard let url = components?.url else {
            return []
        }

        return try await performRequest(url: url)
    }
}
