//
//  MatchDetailsViewController.swift
//  Sofa
//
//  Created by Akademija on 04.04.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class MatchDetailsViewController: UIViewController, BaseViewProtocol {

    private let matchView = EventDetailsView()
    private let viewModel: EventDetailsViewModel
    private let headerViewModel: HeaderDetailsViewModel
    private let headerView = HeaderDetailsView()
    private let backButton = UIButton(type: .system)
    private let safeAreaFillView = UIView()
    private let incidentScrollView = UIScrollView()
    private let incidentStackView = UIStackView()
    private let startingView = StartingView()
    
    private let homeGoalView = HomeGoalView()
    private let awayGoalView = AwayGoalView()
    private let homeIncidentView = HomeIncidentView()
    private let awayIncidentView = AwayIncidentView()
    
    private var incidents: [Incident] = []
    
    
    
    init(event: Event, sport: Sport) {
        self.viewModel = EventDetailsViewModel(event: event)
        self.headerViewModel = HeaderDetailsViewModel(event: event, sport: sport)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundMain
        addViews()
        setupConstraints()
        styleViews()
        
        matchView.update(with: viewModel)
        headerView.configure(with: headerViewModel)
        getData()
    }

    func addViews() {
        view.addSubview(matchView)
        view.addSubview(safeAreaFillView)
        view.addSubview(startingView)
        view.addSubview(incidentScrollView)
        incidentScrollView.addSubview(incidentStackView)
    }

    func setupConstraints() {
        matchView.snp.makeConstraints {
            $0.height.equalTo(112)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        safeAreaFillView.snp.makeConstraints {
            $0.bottom.equalTo(matchView.snp.top)
            $0.leading.trailing.top.equalToSuperview()
        }
        incidentScrollView.snp.makeConstraints {
            $0.top.equalTo(matchView.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        incidentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        startingView.snp.makeConstraints {
            $0.top.equalTo(matchView.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func styleViews() {
        navigationItem.titleView = headerView
        
        safeAreaFillView.backgroundColor = .background
        
        incidentScrollView.backgroundColor = .clear
        incidentStackView.axis = .vertical
        incidentStackView.spacing = 0
        
        backButton.setImage(UIImage(named: "ic_backarrow"), for: .normal)
        backButton.tintColor = .primaryText
        backButton.semanticContentAttribute = .forceLeftToRight
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    func getData() {
        matchView.onTeamTapped = { [weak self] team in
            Task {
                do {
                    let info = try await APIClient.getTeam(id: team.id)
                    let vc = TeamDetailsViewController(teamInfo: info)
                    await MainActor.run {
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                } catch {
                    print("Failed to fetch team info: \(error)")
                }
            }
        }

        Task {
            do {
                let data = try await APIClient.getEventIncidents(eventId: viewModel.eventId)

                await MainActor.run {
                    self.incidents = data
                    self.startingView.isHidden = !data.isEmpty
                    self.incidentScrollView.isHidden = data.isEmpty
                    self.incidentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

                    for incident in data.reversed() {
                        let vm = IncidentViewModel(incident: incident)
                        let view: UIView

                        if incident.isHomeTeam == true {
                            view = (incident.type == .goal) ? HomeGoalView() : HomeIncidentView()
                        } else {
                            view = (incident.type == .goal) ? AwayGoalView() : AwayIncidentView()
                        }

                        if let homeGoal = view as? HomeGoalView {
                            homeGoal.update(with: vm)
                        } else if let awayGoal = view as? AwayGoalView {
                            awayGoal.update(with: vm)
                        } else if let homeIncident = view as? HomeIncidentView {
                            homeIncident.update(with: vm)
                        } else if let awayIncident = view as? AwayIncidentView {
                            awayIncident.update(with: vm)
                        }

                        self.incidentStackView.addArrangedSubview(view)
                    }

                    self.incidentScrollView.layoutIfNeeded()
                    let offsetY = max(0, self.incidentScrollView.contentSize.height - self.incidentScrollView.bounds.height)
                    self.incidentScrollView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: false)
                }

            } catch {
                print("Failed to fetch incidents: \(error)")
            }
        }
    }
}

