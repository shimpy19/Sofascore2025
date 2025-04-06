//
//  ViewController.swift
//  Sofa
//
//  Created by Akademija on 11.03.2025..
//
import Foundation
import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController, BaseViewProtocol {

    let sportSelectorMenu = SportSelectorMenuView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let headerView = HeaderView()
    private let safeAreaFillView = SafeAreaFillView()

    private var leagues: [League] = []
    private var eventsByLeague: [Int: [Event]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()

        headerView.onSettingsTapped = { [weak self] in
            let settingsVC = SettingsViewController()
            self?.navigationController?.pushViewController(settingsVC, animated: true)
        }

        setupTableView()
        loadData(sport: .football)
        
        sportSelectorMenu.onSportSelected = { [weak self] sport in
            self?.loadData(sport: sport)
        }
    }

    func addViews() {
        view.addSubview(safeAreaFillView)
        view.addSubview(sportSelectorMenu)
        view.addSubview(tableView)
        view.addSubview(headerView)
    }

    func styleViews() {
        view.backgroundColor = .backgroundMain
    }

    func setupConstraints() {
        sportSelectorMenu.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalTo(tableView.snp.top)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(sportSelectorMenu.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        headerView.snp.makeConstraints {
            $0.bottom.equalTo(sportSelectorMenu.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }

        safeAreaFillView.snp.makeConstraints {
            $0.bottom.equalTo(headerView.snp.top)
            $0.leading.trailing.top.equalToSuperview()
        }
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
    private func loadData(sport: Sport) {
        Task {
            do {
                let allEvents = try await APIClient.getEvents(sport: sport)
                var addedLeagueIds = Set<Int>()
                var newLeagues: [League] = []
                var newEventsByLeague: [Int: [Event]] = [:]

                for event in allEvents {
                    let league = event.league
                    if !addedLeagueIds.contains(league.id) {
                        newLeagues.append(league)
                        addedLeagueIds.insert(league.id)
                    }
                    newEventsByLeague[league.id, default: []].append(event)
                }

                DispatchQueue.main.async {
                    self.leagues = newLeagues
                    self.eventsByLeague = newEventsByLeague
                    self.tableView.reloadData()
                }
            } catch {
                print("Failed to load events for sport \(sport): \(error)")
            }
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
        header.configure(with: league)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let league = leagues[indexPath.section]
        guard let event = eventsByLeague[league.id]?[indexPath.row] else { return }

        let detailsVC = MatchDetailsViewController(event: event)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
