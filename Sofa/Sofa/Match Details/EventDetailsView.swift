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
    private let homeScoreLabel = UILabel()
    private let awayScoreLabel = UILabel()
    private let dividerLabel = UILabel()
    private let timeLabel = UILabel()
    private let dateLabel = UILabel()
    
    override func addViews() {
        addSubview(homeTeamLabel)
        addSubview(awayTeamLabel)
        addSubview(homeTeamLogoImageView)
        addSubview(awayTeamLogoImageView)
        addSubview(homeScoreLabel)
        addSubview(awayScoreLabel)
        addSubview(dividerLabel)
        addSubview(timeLabel)
        addSubview(dateLabel)
    }
    
    override func styleViews() {
        [homeTeamLabel, awayTeamLabel, dateLabel].forEach {
            $0.textColor = .primaryText
        }
        
        backgroundColor = .background

        homeTeamLabel.font = .bold12
        awayTeamLabel.font = .bold12
        homeScoreLabel.font = .bold32
        awayScoreLabel.font = .bold32
        dividerLabel.font = .bold32
        timeLabel.font = .regular12
        dateLabel.font = .regular12
        
        dividerLabel.textAlignment = .center
        timeLabel.textAlignment = .center
        
        timeLabel.numberOfLines = 2
        timeLabel.lineBreakMode = .byTruncatingTail
        
        homeTeamLabel.numberOfLines = 2
        homeTeamLabel.lineBreakMode = .byTruncatingTail
        homeTeamLabel.textAlignment = .center

        awayTeamLabel.numberOfLines = 2
        awayTeamLabel.lineBreakMode = .byTruncatingTail
        awayTeamLabel.textAlignment = .center

    }
        
    
    override func setupConstraints() {
        homeTeamLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(44)
            $0.size.equalTo(40)
        }
        
        awayTeamLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(44)
            $0.size.equalTo(40)
        }
        
        homeTeamLabel.snp.makeConstraints {
            $0.top.equalTo(homeTeamLogoImageView.snp.bottom).offset(18)
            $0.centerX.equalTo(homeTeamLogoImageView)
            $0.height.lessThanOrEqualTo(32)
            $0.width.lessThanOrEqualTo(96)
            
        }
        
        awayTeamLabel.snp.makeConstraints {
            $0.top.equalTo(awayTeamLogoImageView.snp.bottom).offset(18)
            $0.centerX.equalTo(awayTeamLogoImageView)
            $0.height.lessThanOrEqualTo(32)
            $0.width.lessThanOrEqualTo(96)
        }
        
        dividerLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(homeTeamLogoImageView)
        }

        homeScoreLabel.snp.makeConstraints {
            $0.centerY.equalTo(dividerLabel)
            $0.trailing.equalTo(dividerLabel.snp.leading).offset(-4)
        }

        awayScoreLabel.snp.makeConstraints {
            $0.centerY.equalTo(dividerLabel)
            $0.leading.equalTo(dividerLabel.snp.trailing).offset(4)
        }

        timeLabel.snp.makeConstraints {
            $0.top.equalTo(dividerLabel.snp.bottom).offset(8)
            $0.leading.equalTo(homeTeamLogoImageView.snp.trailing).offset(60)
            $0.trailing.equalTo(awayTeamLogoImageView.snp.leading).offset(-60)
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
        homeScoreLabel.text = viewModel.homeScoreText
        homeScoreLabel.textColor = viewModel.homeScoreColor
        awayScoreLabel.text = viewModel.awayScoreText
        awayScoreLabel.textColor = viewModel.awayScoreColor
        dividerLabel.text = viewModel.scoreDividerText
        dividerLabel.textColor = viewModel.scoreDividerColor
        timeLabel.text = viewModel.timeText
        timeLabel.textColor = viewModel.timeColor
        dateLabel.text = viewModel.dateText
        homeTeamLogoImageView.setImage(with: viewModel.homeLogoUrl)
        awayTeamLogoImageView.setImage(with: viewModel.awayLogoUrl)
    }
}

