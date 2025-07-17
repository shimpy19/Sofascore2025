//
//  MainEventsViewModel.swift
//  Sofa
//
//  Created by Akademija on 10.04.2025..
//
import Foundation
class MainEventsViewModel {
    private(set) var leagues: [League] = []
    private(set) var eventsByLeague: [Int: [Event]] = [:]

    func loadData(for sport: Sport) async throws {
        let events = try await APIClient.getEvents(sport: sport)

        var addedLeagueIds = Set<Int>()
        var newLeagues: [League] = []
        var newEventsByLeague: [Int: [Event]] = [:]

        for event in events {
            let league = event.league
            if !addedLeagueIds.contains(league.id) {
                newLeagues.append(league)
                addedLeagueIds.insert(league.id)
            }
            newEventsByLeague[league.id, default: []].append(event)
        }

        self.leagues = newLeagues
        self.eventsByLeague = newEventsByLeague
    }
}
