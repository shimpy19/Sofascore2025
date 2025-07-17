//
//  AboutTeamView.swift
//  Sofa
//
//  Created by Akademija on 16.06.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TeamInfoView: BaseView {
    
    private let coachImageView = UIImageView()
    private let coachNameLabel = UILabel()
    private let coachCountryLabel = UILabel()
    private let teamInfotitleLabel = UILabel()
    private let totalPlayersNumLabel = UILabel()
    private let foreignPlayersNumLabel = UILabel()
    private let totalPlayerIconImageView = UIImageView()
    private let foreignPlayersLabel = UILabel()
    private let totalPlayersLabel = UILabel()
    private let horizontalDivider = UIView()
    private let donutProgressView = DonutProgressView()
    
    override init() {
        super.init()
    }
    
    override func addViews() {
        addSubview(coachImageView)
        addSubview(coachNameLabel)
        addSubview(coachCountryLabel)
        addSubview(teamInfotitleLabel)
        addSubview(totalPlayersLabel)
        addSubview(totalPlayerIconImageView)
        addSubview(foreignPlayersLabel)
        addSubview(totalPlayersNumLabel)
        addSubview(foreignPlayersNumLabel)
        addSubview(horizontalDivider)
        addSubview(donutProgressView)
    }
    
    override func styleViews() {
        
        backgroundColor = .background
        
        teamInfotitleLabel.font = .bold16
        teamInfotitleLabel.textColor = .primaryText
        teamInfotitleLabel.text = "Team Info"
        
        coachImageView.contentMode = .scaleAspectFill
        coachImageView.clipsToBounds = true
        coachImageView.layer.cornerRadius = 20
        
        coachNameLabel.font = .regular14
        coachNameLabel.textColor = .primaryText
        
        coachCountryLabel.font = .bold12
        coachCountryLabel.textColor = .secondaryText
        
        totalPlayersLabel.font = .regular12
        totalPlayersLabel.textColor = .secondaryText
        foreignPlayersLabel.font = .regular12
        foreignPlayersLabel.textColor = .secondaryText
        
        foreignPlayersNumLabel.font = .regular14
        foreignPlayersNumLabel.textColor = .sofaBlue
        totalPlayersNumLabel.font = .regular14
        totalPlayersNumLabel.textColor = .sofaBlue
        
        horizontalDivider.backgroundColor = .backgroundMain
        
        totalPlayerIconImageView.image = UIImage(named: "ic_team")
        
        foreignPlayersLabel.text = "Foreign Players"
        totalPlayersLabel.text = "Total Players"
        
    }
    override func setupConstraints() {
        teamInfotitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }

        coachImageView.snp.makeConstraints {
            $0.top.equalTo(teamInfotitleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(40)
        }

        coachNameLabel.snp.makeConstraints {
            $0.top.equalTo(coachImageView.snp.top)
            $0.leading.equalTo(coachImageView.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
        }

        coachCountryLabel.snp.makeConstraints {
            $0.top.equalTo(coachNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(coachNameLabel)
        }

        horizontalDivider.snp.makeConstraints {
            $0.top.equalTo(coachImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        totalPlayerIconImageView.snp.makeConstraints {
            $0.top.equalTo(horizontalDivider.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(40)
            $0.size.equalTo(40)
        }

        totalPlayersNumLabel.snp.makeConstraints {
            $0.top.equalTo(totalPlayerIconImageView.snp.bottom).offset(4)
            $0.centerX.equalTo(totalPlayerIconImageView)
        }

        totalPlayersLabel.snp.makeConstraints {
            $0.top.equalTo(totalPlayersNumLabel.snp.bottom).offset(2)
            $0.centerX.equalTo(totalPlayersNumLabel)
        }

        donutProgressView.snp.makeConstraints {
            $0.top.equalTo(horizontalDivider.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().offset(-40)
            $0.size.equalTo(40)
        }

        foreignPlayersNumLabel.snp.makeConstraints {
            $0.top.equalTo(donutProgressView.snp.bottom).offset(4)
            $0.centerX.equalTo(donutProgressView)
        }

        foreignPlayersLabel.snp.makeConstraints {
            $0.top.equalTo(foreignPlayersNumLabel.snp.bottom).offset(2)
            $0.centerX.equalTo(donutProgressView)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func update(with viewModel: TeamInfoViewModel) {
        coachImageView.setImage(with: viewModel.coachImageUrl)
        coachNameLabel.text = viewModel.coachName
        coachCountryLabel.text = viewModel.coachCountry
        totalPlayersNumLabel.text = viewModel.totalPlayers
        foreignPlayersNumLabel.text = viewModel.foreignPlayers
        donutProgressView.progress = viewModel.progress
    }
    }

        
        
        

    
    
    
    

