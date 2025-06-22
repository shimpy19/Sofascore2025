//
//  LeagueDetailsInfoView.swift
//  Sofa
//
//  Created by Akademija on 09.06.2025..
//


import UIKit
import SnapKit
import SofaAcademic


class LeagueDetailsInfoView: BaseView {
    
    private let whiteSquare = UIView()
    private let leagueNameLabel = UILabel()
    private let leagueLogoImageView = UIImageView()
    private let leagueCountryLabel = UILabel()


    override func addViews() {
        addSubview(whiteSquare)
        addSubview(leagueLogoImageView)
        addSubview(leagueNameLabel)
        addSubview(leagueCountryLabel)
    }

    override func styleViews() {
        backgroundColor = .sofaBlue
        
        whiteSquare.backgroundColor = .background
        whiteSquare.layer.cornerRadius = 12 
        whiteSquare.clipsToBounds = true
        
        leagueLogoImageView.contentMode = .scaleAspectFit

        leagueNameLabel.numberOfLines = 1
        leagueNameLabel.font = .bold20
        leagueNameLabel.textColor = .background
        leagueNameLabel.textAlignment = .center
        
        leagueCountryLabel.numberOfLines = 1
        leagueCountryLabel.font = .bold16
        leagueCountryLabel.textColor = .background
        leagueCountryLabel.textAlignment = .center
    }

    override func setupConstraints() {

        leagueNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-40)
            $0.leading.equalTo(whiteSquare.snp.trailing).offset(16)
        }
        whiteSquare.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(56)
        }
        leagueLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-24)
            $0.leading.equalToSuperview().offset(24)
            $0.size.equalTo(40)
        }
        leagueCountryLabel.snp.makeConstraints {
            $0.top.equalTo(leagueNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(whiteSquare.snp.trailing).offset(24)
        }
            
    }
    
    func update(with league: League) {
        leagueLogoImageView.setImage(with: league.logoUrl)
        leagueCountryLabel.text = league.country?.name
        leagueNameLabel.text = league.name
    }
}

