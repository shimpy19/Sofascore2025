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

class MainEventsViewController: UIViewController, BaseViewProtocol {

    let sportSelectorMenu = SportSelectorMenuView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let headerView = MainEventsHeaderView()
    private let safeAreaFillView = UIView()
    private let viewModel = MainEventsViewModel()
    private var selectedSport: Sport = .football


    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        setupGestureRecognizers()

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
        safeAreaFillView.backgroundColor = .sofaBlue
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

    func setupGestureRecognizers() {
        headerView.onSettingsTapped = { [weak self] in
            let settingsVC = SettingsViewController()
            self?.navigationController?.pushViewController(settingsVC, animated: true)
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
        selectedSport = sport
        Task {
            do {
                try await viewModel.loadData(for: sport)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Failed to load events for sport \(sport): \(error)")
            }
        }
    }
}

extension MainEventsViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.leagues.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < viewModel.leagues.count else { return 0 }
        let league = viewModel.leagues[section]
        return viewModel.eventsByLeague[league.id]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < viewModel.leagues.count else { return nil }
        let league = viewModel.leagues[section]
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: LeagueHeaderView.reuseIdentifier) as? LeagueHeaderView else {
            return nil
        }
        header.configure(with: league)
        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section < viewModel.leagues.count else { return UITableViewCell() }
        let league = viewModel.leagues[indexPath.section]
        guard let event = viewModel.eventsByLeague[league.id]?[indexPath.row] else { return UITableViewCell() }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseIdentifier, for: indexPath) as? EventCell else {
            return UITableViewCell()
        }

        let viewModel = EventViewModel(event: event)
        cell.configure(with: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section < viewModel.leagues.count else { return }
        let league = viewModel.leagues[indexPath.section]
        guard let event = viewModel.eventsByLeague[league.id]?[indexPath.row] else { return }

        openMatchDetails(for: event, for: selectedSport)
    }

    private func openMatchDetails(for event: Event, for sport: Sport) {
        let detailsVC = MatchDetailsViewController(event: event, sport: sport)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
