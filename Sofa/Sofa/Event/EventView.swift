//
//  EventView.swift
//  Sofa
//
//  Created by Akademija on 13.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class EventView: BaseView {
    
    private let homeTeamView: EventTeamView
    private let awayTeamView: EventTeamView
    private let timeLabel = UILabel()
    private let dividerView = DividerView()
    private let startTimeLabel = UILabel()
    private let homeScoreLabel = UILabel()
    private let awayScoreLabel = UILabel()
    private let stackView = UIStackView()
    
    private let viewModel: EventViewModel
    
    init(viewModel: EventViewModel) {
        self.viewModel = viewModel
        self.homeTeamView = EventTeamView(team: viewModel.event.homeTeam, event: viewModel.event)
        self.awayTeamView = EventTeamView(team: viewModel.event.awayTeam, event: viewModel.event)
        super.init()
    }
    
    override func addViews() {
        stackView.addArrangedSubview(homeTeamView)
        stackView.addArrangedSubview(awayTeamView)
        addSubview(stackView)
        addSubview(timeLabel)
        addSubview(dividerView)
        addSubview(startTimeLabel)
        addSubview(homeScoreLabel)
        addSubview(awayScoreLabel)
    }
    
    override func styleViews() {
        backgroundColor = .background
        
        timeLabel.font = .regular12
        timeLabel.textColor = viewModel.timeColor
        timeLabel.textAlignment = .center
        timeLabel.text = viewModel.timeText
        
        homeScoreLabel.font = .regular14
        homeScoreLabel.textColor = viewModel.scoreColor
        homeScoreLabel.text = viewModel.homeScoreText
        
        awayScoreLabel.font = .regular14
        awayScoreLabel.textColor = viewModel.scoreColor
        awayScoreLabel.text = viewModel.awayScoreText
        
        startTimeLabel.font = .regular12
        startTimeLabel.textColor = .secondaryText
        startTimeLabel.textAlignment = .center
        startTimeLabel.text = viewModel.formattedStartTime
        
        dividerView.backgroundColor = .secondaryText
        
        stackView.axis = .vertical
        stackView.spacing = 4 
    }
    
    override func setupConstraints() {
        
        stackView.snp.makeConstraints {
                    $0.top.equalToSuperview().offset(10)
                    $0.leading.equalTo(dividerView.snp.trailing).offset(16)
                    $0.bottom.equalToSuperview().inset(10)
        }
        
        dividerView.snp.makeConstraints {
            $0.leading.equalTo(startTimeLabel.snp.trailing).offset(4)
            $0.width.equalTo(1)
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        startTimeLabel.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.width.equalTo(56)
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(4)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(4)
            $0.top.equalTo(startTimeLabel.snp.bottom).offset(8)
            $0.height.equalTo(16)
            $0.width.equalTo(56)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        awayScoreLabel.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.width.equalTo(32)
            $0.trailing.equalToSuperview().offset(16)
            $0.top.equalTo(homeScoreLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        homeScoreLabel.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.width.equalTo(32)
            $0.trailing.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(10)
        }
    }
    class DividerView: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.tintColor = .secondaryText
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.backgroundColor = .secondaryText
        }
    }
}
