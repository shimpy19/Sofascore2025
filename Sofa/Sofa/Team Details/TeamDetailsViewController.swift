//
//  TeamDetailsViewController.swift
//  Sofa
//
//  Created by Akademija on 15.06.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class TeamDetailsViewController: UIViewController, BaseViewProtocol {

    
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    
    private var teamInfo: TeamInfo
    private var nextEvent: Event?
    private var sport: Sport?
    private var tournaments: [League] = []
    private var players: [Player] = []
    private var teamInfoViewModel: TeamInfoViewModel
        


    private let teamDetailsInfoView = TeamDetailsInfoView()
    private let selectorMenu: TeamDetailsSelectorMenuView
    private let teamDetailsContentView = TeamDetailsContentView()
    private let backButton = UIButton()
    private let safeAreaFillView = UIView()
    
    private let coachView = CoachView()
    private let playersTableView = UITableView()

    init(teamInfo: TeamInfo) {
        self.selectorMenu = TeamDetailsSelectorMenuView()
        self.teamInfo = teamInfo
        self.teamInfoViewModel = TeamInfoViewModel(teamInfo: teamInfo)
        super.init(nibName: nil, bundle: nil)
        self.teamDetailsInfoView.update(with: teamInfo)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundMain

        styleViews()
        addViews()
        setupConstraints()
        getData()
        setupPlayersTableView()
        selectorPick()

        self.teamDetailsInfoView.update(with: teamInfo)
        }

    func addViews() {
        view.addSubview(safeAreaFillView)
        view.addSubview(scrollView)
        view.addSubview(contentStackView)
        scrollView.addSubview(teamDetailsContentView)
        view.addSubview(backButton)
        
        view.addSubview(coachView)
        view.addSubview(playersTableView)

        contentStackView.addArrangedSubview(teamDetailsInfoView)
        contentStackView.addArrangedSubview(selectorMenu)
    }

    func setupConstraints() {
        safeAreaFillView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(contentStackView.snp.top)
        }

        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(4)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.size.equalTo(48)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(contentStackView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        contentStackView.snp.makeConstraints {
            $0.bottom.equalTo(scrollView.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(backButton.snp.bottom)
        }
        
        teamDetailsContentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        coachView.snp.makeConstraints {
            $0.top.equalTo(contentStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        playersTableView.snp.makeConstraints {
            $0.top.equalTo(coachView.snp.bottom).offset(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }

    }

    func styleViews() {
        contentStackView.axis = .vertical
        contentStackView.spacing = 0

        backButton.setImage(UIImage(named: "ic_arrow_back"), for: .normal)
        backButton.tintColor = .background
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)

        safeAreaFillView.backgroundColor = .sofaBlue
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
    
    func applyDataIfAvailable() {
        teamDetailsContentView.update(
            with: teamInfo,
            event: nextEvent,
            sport: sport,
            tournaments: tournaments,
            teamInfoViewModel: teamInfoViewModel
        )
    }
    
    func getData(){
        Task {
            do {
                let players = try await APIClient.getTeamPlayers(id: teamInfo.team.id)
                StorageManager.shared.savePlayers(players, forTeamId: teamInfo.team.id)
                self.players = players
                
                self.tournaments = try await APIClient.getTeamTournaments(id: teamInfo.team.id)
                applyDataIfAvailable()
                coachView.update(with: teamInfo)
                playersTableView.reloadData()
            } catch {
                print("Error fetching tournaments: \(error)")
            }
        }
    }
    func selectorPick(){
        selectorMenu.onTeamDetailSelected = { [weak self] details in
            guard let self = self else { return }

            switch details {
            case .squad:
                self.coachView.isHidden = false
                self.playersTableView.isHidden = false
                self.teamDetailsContentView.isHidden = true

            case .details:
                self.coachView.isHidden = true
                self.playersTableView.isHidden = true
                self.teamDetailsContentView.isHidden = false
            }
        }
    }
    func setupPlayersTableView() {
        playersTableView.delegate = self
        playersTableView.dataSource = self
        playersTableView.register(PlayerCell.self, forCellReuseIdentifier: PlayerCell.reuseIdentifier)
        playersTableView.separatorStyle = .none
        playersTableView.isScrollEnabled = true
        playersTableView.isHidden = true
        coachView.isHidden = true
    }
}

extension TeamDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerCell.reuseIdentifier, for: indexPath) as? PlayerCell else {
            return UITableViewCell()
        }
        cell.update(with: players[indexPath.row])
        return cell
    }
}
    
    
