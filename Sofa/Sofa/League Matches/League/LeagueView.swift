//
//  LeagueView.swift
//  Sofa
//
//  Created by Akademija on 28.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class LeagueView: BaseView {

    private let logoImageView = UIImageView()
    private let countryLabel = UILabel()
    private let iconImageView = UIImageView()
    private let leagueLabel = UILabel()

    override func addViews() {
        addSubview(logoImageView)
        addSubview(countryLabel)
        addSubview(iconImageView)
        addSubview(leagueLabel)
    }

    override func styleViews() {
        backgroundColor = .background

        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true

        countryLabel.font = .bold14
        countryLabel.textColor = .primaryText

        leagueLabel.font = .regular14
        leagueLabel.textColor = .secondaryText

        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: "ic_pointer_right")
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.leading.equalToSuperview().offset(16)
            $0.top.bottom.equalToSuperview().inset(12)
        }

        countryLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(32)
            $0.top.bottom.equalToSuperview().inset(20)
        }

        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.leading.equalTo(countryLabel.snp.trailing)
            $0.top.bottom.equalToSuperview().inset(16)
        }

        leagueLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing)
            $0.top.bottom.equalToSuperview().inset(20)
        }
    }
    
    func update(with league: League) {
        logoImageView.setImage(with: league.logoUrl)
        countryLabel.text = league.country?.name
        leagueLabel.text = league.name
    }
}
