//
//  TeamDetailsContentView.swift
//  Sofa
//
//  Created by Akademija on 17.06.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class TeamDetailsContentView: BaseView {

    private let teamInfoView = TeamInfoView()
    private let tournamentsView = TournamentsView()
    private let nextMatchView = NextMatchView()
    private let venueView = VenueView()

    override func addViews() {
        addSubview(teamInfoView)
        addSubview(tournamentsView)
        addSubview(nextMatchView)
        addSubview(venueView)
    }

    override func setupConstraints() {
        teamInfoView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        tournamentsView.snp.makeConstraints {
            $0.top.equalTo(teamInfoView.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
        }

        venueView.snp.makeConstraints {
            $0.top.equalTo(tournamentsView.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
        }

        nextMatchView.snp.makeConstraints {
            $0.top.equalTo(venueView.snp.bottom).offset(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }


    func update(with teamInfo: TeamInfo, event: Event?, sport: Sport?, tournaments: [League], teamInfoViewModel: TeamInfoViewModel) {
        teamInfoView.update(with: teamInfoViewModel)
        venueView.update(with: teamInfo)
        tournamentsView.update(with: tournaments)

        if let event = event, let sport = sport {
            nextMatchView.update(with: event, sport: sport)
        }
    }
}
