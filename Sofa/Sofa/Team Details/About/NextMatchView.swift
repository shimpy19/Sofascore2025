//
//  NextMatchView.swift
//  Sofa
//
//  Created by Akademija on 17.06.2025..
//
import UIKit
import SnapKit
import SofaAcademic

class NextMatchView: BaseView {
    
    private let titleLabel = UILabel()
    private let leagueHeaderView = LeagueHeaderView()
    private let eventView = EventView()

    var onTap: (() -> Void)?

    override func addViews() {
        addSubview(titleLabel)
        addSubview(leagueHeaderView)
        addSubview(eventView)
    }

    override func styleViews() {
        backgroundColor = .background
        titleLabel.text = "Next match"
        titleLabel.font = .bold16
        titleLabel.textColor = .primaryText
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }

        leagueHeaderView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }

        eventView.snp.makeConstraints {
            $0.top.equalTo(leagueHeaderView.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func update(with event: Event, sport: Sport) {
        let viewModel = EventViewModel(event: event)
        eventView.update(with: viewModel)

        leagueHeaderView.configure(with: event.league) {
            self.onTap?()
        }
    }
}
