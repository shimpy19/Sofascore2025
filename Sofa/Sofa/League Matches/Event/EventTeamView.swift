//
//  EventTeamView.swift
//  Sofa
//
//  Created by Akademija on 18.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class EventTeamView: BaseView {
    
    private let homeTeamLogoImageView = UIImageView()
    private let homeTeamNameLabel = UILabel()
    private let homeScoreLabel = UILabel()
    private let awayTeamLogoImageView = UIImageView()
    private let awayTeamNameLabel = UILabel()
    private let awayScoreLabel = UILabel()
    
    private let event: Event
    
    init(event: Event) {
        self.event = event
        super.init()
    }
    
    override func addViews() {
        addSubview(homeTeamLogoImageView)
        addSubview(homeTeamNameLabel)
        addSubview(homeScoreLabel)
        addSubview(awayTeamLogoImageView)
        addSubview(awayTeamNameLabel)
        addSubview(awayScoreLabel)
    }
    
    override func styleViews() {
        homeTeamLogoImageView.contentMode = .scaleAspectFit
        awayTeamLogoImageView.contentMode = .scaleAspectFit
        
        homeTeamNameLabel.font = .regular14
        homeTeamNameLabel.textColor = .primaryText
        
        awayTeamNameLabel.font = .regular14
        awayTeamNameLabel.textColor = .primaryText
        
        if let logoUrl = event.homeTeam.logoUrl, let url = URL(string: logoUrl) {
            homeTeamLogoImageView.loadImage(from: url)
        }
        if let logoUrl = event.awayTeam.logoUrl, let url = URL(string: logoUrl) {
            awayTeamLogoImageView.loadImage(from: url)
        }
        
        homeTeamNameLabel.text = event.homeTeam.name
        awayTeamNameLabel.text = event.awayTeam.name
        
        homeScoreLabel.font = .regular14
        awayScoreLabel.font = .regular14
        homeScoreLabel.text = event.homeScore != nil ? "\(event.homeScore!)" : ""
        awayScoreLabel.text = event.awayScore != nil ? "\(event.awayScore!)" : ""

        
        if event.status == .inProgress {
            homeScoreLabel.textColor = .inProgress
            awayScoreLabel.textColor = .inProgress
        }
        else {
            homeScoreLabel.textColor = .secondaryText
            awayScoreLabel.textColor = .secondaryText
        }
        
    }
    
    override func setupConstraints() {
        homeTeamLogoImageView.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalTo(awayTeamLogoImageView.snp.top).offset(-4)
            $0.leading.equalToSuperview()
        }
        
        homeTeamNameLabel.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.leading.equalTo(homeTeamLogoImageView.snp.trailing).offset(8)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalTo(awayTeamNameLabel.snp.top).offset(-4)
            
        }
        awayTeamLogoImageView.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
            $0.top.equalTo(homeTeamLogoImageView.snp.bottom).offset(4)
        }
        
        awayTeamNameLabel.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.leading.equalTo(awayTeamLogoImageView.snp.trailing).offset(8)
            $0.bottom.equalToSuperview().offset(-10)
            $0.top.equalTo(homeTeamNameLabel.snp.bottom).offset(4)
            
        }
        awayScoreLabel.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.width.equalTo(32)
            $0.trailing.equalToSuperview().offset(16)
            $0.top.equalTo(homeScoreLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        homeScoreLabel.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.width.equalTo(32)
            $0.trailing.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalTo(awayScoreLabel.snp.top).offset(-4)
            
            
        }
    }
}
