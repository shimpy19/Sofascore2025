//
//  LeagueDetailsInfoView.swift
//  Sofa
//
//  Created by Akademija on 09.06.2025..
//


import UIKit
import SnapKit
import SofaAcademic

class TeamDetailsInfoView: BaseView {
    
    private let whiteSquare = UIView()
    private let teamLogoImageView = UIImageView()
    private let teamNameLabel = UILabel()
    private let teamCountryLabel = UILabel()

    override func addViews() {
        addSubview(whiteSquare)
        addSubview(teamLogoImageView)
        addSubview(teamNameLabel)
        addSubview(teamCountryLabel)
    }

    override func styleViews() {
        backgroundColor = .sofaBlue
        
        whiteSquare.backgroundColor = .background
        whiteSquare.layer.cornerRadius = 12
        whiteSquare.clipsToBounds = true
        
        teamLogoImageView.contentMode = .scaleAspectFit

        teamNameLabel.numberOfLines = 1
        teamNameLabel.font = .bold20
        teamNameLabel.textColor = .background
        teamNameLabel.textAlignment = .center
        
        teamCountryLabel.numberOfLines = 1
        teamCountryLabel.font = .bold16
        teamCountryLabel.textColor = .background
        teamCountryLabel.textAlignment = .center
    }

    override func setupConstraints() {
        teamNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-40)
            $0.leading.equalTo(whiteSquare.snp.trailing).offset(16)
        }

        whiteSquare.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(56)
        }

        teamLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-24)
            $0.leading.equalToSuperview().offset(24)
            $0.size.equalTo(40)
        }

        teamCountryLabel.snp.makeConstraints {
            $0.top.equalTo(teamNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(whiteSquare.snp.trailing).offset(24)
        }
    }
    
    func update(with teamInfo: TeamInfo) {
        teamLogoImageView.setImage(with: teamInfo.team.logoUrl)
        teamNameLabel.text = teamInfo.team.name
        teamCountryLabel.text = teamInfo.team.country?.name
    }

}
