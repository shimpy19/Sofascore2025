//
//  LeagueMatchesView.swift
//  Sofa
//
//  Created by Akademija on 23.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class LeagueMatchesView: BaseView {

    private let tableView = UITableView()
    private var leagues: [League] = []
    private var events: [Event] = []

    init(leagues: [League], events: [Event]) {
        self.leagues = leagues
        self.events = events
        super.init()
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func addViews() {
        addSubview(tableView)
    }

    override func styleViews() {
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
    }

    override func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
}

extension LeagueMatchesView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return leagues.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let league = leagues[section]
        let leagueView = LeagueView(league: league)
        return leagueView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let league = leagues[indexPath.section]
        let leagueEvents = events.filter { event in
            guard let eventLeague = event.league else { return false }
            return eventLeague.id == league.id
        }
        let gamesView = GamesView(events: leagueEvents)
        cell.contentView.addSubview(gamesView)
        gamesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return cell
    }
}
