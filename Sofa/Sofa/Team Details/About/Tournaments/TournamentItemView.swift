//
//  TournamentItemView.swift
//  Sofa
//
//  Created by Akademija on 17.06.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class TournamentItemView: BaseView {

    private let leagueLogoImageView = UIImageView()
    private let leagueNameLabel = UILabel()

    override func addViews() {
        addSubview(leagueLogoImageView)
        addSubview(leagueNameLabel)
    }

    override func styleViews() {
        leagueLogoImageView.contentMode = .scaleAspectFit
        leagueLogoImageView.clipsToBounds = true
        leagueLogoImageView.layer.cornerRadius = 8

        leagueNameLabel.font = .regular12
        leagueNameLabel.textAlignment = .center
        leagueNameLabel.numberOfLines = 2
        leagueNameLabel.textColor = .secondaryText
    }

    override func setupConstraints() {
        leagueLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(40)
        }

        leagueNameLabel.snp.makeConstraints {
            $0.top.equalTo(leagueLogoImageView.snp.bottom).offset(4)
            $0.centerX.equalTo(leagueLogoImageView)
            $0.bottom.equalToSuperview()
        }
    }

    func update(with league: League) {
        leagueNameLabel.text = league.name
        leagueLogoImageView.setImage(with: league.logoUrl)
    }
}

