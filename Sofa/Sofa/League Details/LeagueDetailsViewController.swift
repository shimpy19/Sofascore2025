//
//  LeagueDetailsViewController.swift
//  Sofa
//
//  Created by Akademija on 09.06.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class LeagueDetailsViewController: UIViewController, BaseViewProtocol {
    
    private let league: League
    private let sport: Sport
    private let selectorMenu: LeagueDetailsSelectorMenuView
    private let leagueDetailsInfoView = LeagueDetailsInfoView()
    private let backButton = UIButton()
    private let safeAreaFillView = UIView()
    private let matchesTableView = UITableView()
    
    private let standingsTemplateView = StandingsTemplateView()
    private let standingsTableView = UITableView()
    private var standingViewModels: [StandingViewModel] = []
    
    
    private var eventsByRound: [Int: [Event]] = [:]
    private var sortedRounds: [Int] = []
    
    init(league: League, sport: Sport) {
        self.sport = sport
        self.league = league
        self.selectorMenu = LeagueDetailsSelectorMenuView(league: league)
        super.init(nibName: nil, bundle: nil)
        self.leagueDetailsInfoView.update(with: league)
        
        self.selectorMenu.onLeagueDetailSelected = { [weak self] detail in
            guard let self = self else { return }
            switch detail {
            case .matches:
                self.matchesTableView.isHidden = false
                self.standingsTemplateView.isHidden = true
                self.standingsTableView.isHidden = true
            case .standings:
                self.matchesTableView.isHidden = true
                self.standingsTemplateView.isHidden = false
                self.standingsTableView.isHidden = false
                self.loadStandings()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundMain
        
        setupStandingsTableView()
        setupTableView()
        styleViews()
        addViews()
        setupConstraints()
        loadStandings()
        getData()
    }
    
    func addViews() {
        view.addSubview(safeAreaFillView)
        view.addSubview(selectorMenu)
        view.addSubview(backButton)
        view.addSubview(matchesTableView)
        view.addSubview(standingsTemplateView)
        view.addSubview(standingsTableView)
        view.addSubview(leagueDetailsInfoView)
        
    }
    
    func setupConstraints() {
        safeAreaFillView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(selectorMenu.snp.top)
        }
        leagueDetailsInfoView.snp.makeConstraints {
            $0.bottom.equalTo(selectorMenu.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(backButton.snp.bottom)
        }
        
        selectorMenu.snp.makeConstraints {
            $0.top.equalTo(leagueDetailsInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(matchesTableView.snp.top)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(4)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.size.equalTo(48)
        }
        
        matchesTableView.snp.makeConstraints {
            $0.top.equalTo(selectorMenu.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        standingsTemplateView.snp.makeConstraints {
            $0.top.equalTo(selectorMenu.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        standingsTableView.snp.makeConstraints {
            $0.top.equalTo(standingsTemplateView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    func styleViews() {
        backButton.setImage(UIImage(named: "ic_arrow_back"), for: .normal)
        backButton.tintColor = .background
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        safeAreaFillView.backgroundColor = .sofaBlue
        
        standingsTemplateView.isHidden = true
        standingsTableView.isHidden = true
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    private func setupTableView() {
        matchesTableView.delegate = self
        matchesTableView.dataSource = self
        matchesTableView.separatorStyle = .none
        matchesTableView.backgroundColor = .clear
        matchesTableView.register(RoundCell.self, forCellReuseIdentifier: "RoundCell")
    }
    private func setupStandingsTableView() {
        standingsTableView.delegate = self
        standingsTableView.dataSource = self
        standingsTableView.separatorStyle = .none
        standingsTableView.backgroundColor = .clear
        standingsTableView.register(StandingCell.self, forCellReuseIdentifier: "StandingCell")
    }
    private func loadStandings() {
        Task {
            do {
                let standings = try await APIClient.getLeagueStandings(id: league.id)
                self.standingViewModels = standings.map { StandingViewModel(standings: $0,sport: self.sport) }
                self.standingsTableView.reloadData()
            } catch {
                print("Failed to load standings: \(error)")
            }
        }
        
        if let firstModel = self.standingViewModels.first {
            self.standingsTemplateView.update(with: firstModel)
        }
    }
    func getData(){
        Task {
            do {
                let events = try await APIClient.getLeagueMatches(id: league.id)
                self.eventsByRound = Dictionary(grouping: events) { $0.round }
                self.sortedRounds = self.eventsByRound.keys.sorted()
                self.matchesTableView.reloadData()
            } catch {
                print("Failed to load events: \(error)")
            }
        }
    }
}

extension LeagueDetailsViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == matchesTableView {
            return sortedRounds.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .primaryText
        header.textLabel?.font = .bold12
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == matchesTableView {
            return "Round \(sortedRounds[section])"
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == matchesTableView {
            let round = sortedRounds[indexPath.section]
            guard let event = eventsByRound[round]?[indexPath.row] else {
                return UITableViewCell()
            }

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RoundCell", for: indexPath) as? RoundCell else {
                return UITableViewCell()
            }

            let viewModel = RoundEventViewModel(event: event)
            cell.configure(with: viewModel)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StandingCell", for: indexPath) as? StandingCell else {
                return UITableViewCell()
            }

            let viewModel = standingViewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == matchesTableView {
            guard section < sortedRounds.count else { return 0 }
            let round = sortedRounds[section]
            return eventsByRound[round]?.count ?? 0
        } else {
            return standingViewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == standingsTableView {
            let selectedStanding = standingViewModels[indexPath.row]
            let team = selectedStanding.team
            
            Task {
                do {
                    let teamInfo = try await APIClient.getTeam(id: team.id)
                    let teamDetailsVC = TeamDetailsViewController(teamInfo: teamInfo)
                    self.navigationController?.pushViewController(teamDetailsVC, animated: true)
                } catch {
                    print("Failed to fetch team info: \(error)")
                }
            }
        }
    }
}
