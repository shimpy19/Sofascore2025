//
//  EventDetailsView.swift
//  Sofa
//
//  Created by Akademija on 04.04.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class EventDetailsView: BaseView {
    
    private let homeTeamLabel = UILabel()
    private let awayTeamLabel = UILabel()
    private let homeTeamLogoImageView = UIImageView()
    private let awayTeamLogoImageView = UIImageView()
    private let scoreLabel = UILabel()
    private let timeLabel = UILabel()
    private let dateLabel = UILabel()
    
    override func addViews() {
        addSubview(homeTeamLabel)
        addSubview(awayTeamLabel)
        addSubview(homeTeamLogoImageView)
        addSubview(awayTeamLogoImageView)
        addSubview(scoreLabel)
        addSubview(timeLabel)
        addSubview(dateLabel)
    }
    
    override func styleViews() {
        [homeTeamLabel, awayTeamLabel, scoreLabel,dateLabel].forEach {
            $0.textColor = .primaryText
            
        }
        
        backgroundColor = .background

        homeTeamLabel.font = .bold12
        awayTeamLabel.font = .bold12
        scoreLabel.font = .bold32
        timeLabel.font = .regular12
        dateLabel.font = .regular12
        
        scoreLabel.textAlignment = .center
        timeLabel.textAlignment = .center
    }
        
    
    override func setupConstraints() {
        homeTeamLabel.snp.makeConstraints {
            $0.top.equalTo(homeTeamLogoImageView.snp.bottom).offset(18)
            $0.centerX.equalTo(homeTeamLogoImageView)
        }
        
        awayTeamLabel.snp.makeConstraints {
            $0.top.equalTo(awayTeamLogoImageView.snp.bottom).offset(18)
            $0.centerX.equalTo(awayTeamLogoImageView)
        }
        
        scoreLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(56)
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(scoreLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        homeTeamLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().inset(44)
            $0.size.equalTo(40)
        }
        
        awayTeamLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(44)
            $0.size.equalTo(40)
        }
        
        dateLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(56)
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        
    }
    
    func update(with viewModel: EventDetailsViewModel) {
        homeTeamLabel.text = viewModel.homeName
        awayTeamLabel.text = viewModel.awayName
        scoreLabel.text = viewModel.scoreText
        scoreLabel.textColor = viewModel.scoreColor
        timeLabel.text = viewModel.timeText
        timeLabel.textColor = viewModel.timeColor
        dateLabel.text = viewModel.dateText
        homeTeamLogoImageView.setImage(with: viewModel.homeLogoUrl)
        awayTeamLogoImageView.setImage(with: viewModel.awayLogoUrl)
    }
}

