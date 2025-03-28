//
//  ViewController.swift
//  Sofa
//
//  Created by Akademija on 11.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {

    let dataSource = Homework3DataSource()
    let sportSelectorMenu = SportSelectorMenuView()
    private let tableView = UITableView(frame: .zero, style: .plain)

    private var leagues: [League] = []
    private var eventsByLeague: [Int: [Event]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundMain
        view.addSubview(sportSelectorMenu)
        view.addSubview(tableView)

        sportSelectorMenu.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(tableView.snp.top)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(sportSelectorMenu.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        setupTableView()
        loadData()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.reuseIdentifier)
        tableView.register(LeagueHeaderView.self, forHeaderFooterViewReuseIdentifier: LeagueHeaderView.reuseIdentifier)
        tableView.sectionHeaderTopPadding = 0
    }

    private func loadData() {
        let allEvents = dataSource.events()
        var addedLeagueIds = Set<Int>()

        for event in allEvents {
            guard let league = event.league else { continue }
            if !addedLeagueIds.contains(league.id) {
                leagues.append(league)
                addedLeagueIds.insert(league.id)
            }
            eventsByLeague[league.id, default: []].append(event)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return leagues.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let league = leagues[section]
        return eventsByLeague[league.id]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let league = leagues[section]
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: LeagueHeaderView.reuseIdentifier) as? LeagueHeaderView else {
            return nil
        }
        header.league = league
        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseIdentifier, for: indexPath) as? EventCell else {
            return UITableViewCell()
        }
        let league = leagues[indexPath.section]
        if let event = eventsByLeague[league.id]?[indexPath.row] {
            let viewModel = EventViewModel(event: event)
            cell.configure(with: viewModel)

        }
        return cell
    }
}
