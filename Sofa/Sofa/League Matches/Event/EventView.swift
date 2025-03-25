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
    
    private let eventTeamView: EventTeamView
    private let timeLabel = UILabel()
    private let dividerView = DividerView()
    private let startTimeLabel = UILabel()
    private let teamsVerticalStackView = UIStackView()
    
    private let viewModel: EventViewModel
    
    init(viewModel: EventViewModel) {
        self.viewModel = viewModel
        self.eventTeamView = EventTeamView(event: viewModel.event)
        super.init()
    }
    
    override func addViews() {
        teamsVerticalStackView.addArrangedSubview(eventTeamView)
        addSubview(teamsVerticalStackView)
        addSubview(timeLabel)
        addSubview(dividerView)
        addSubview(startTimeLabel)
    }
    
    override func styleViews() {
        backgroundColor = .background
        
        timeLabel.font = .regular12
        timeLabel.textColor = viewModel.timeColor
        timeLabel.textAlignment = .center
        timeLabel.text = viewModel.timeText
        
        
        startTimeLabel.font = .regular12
        startTimeLabel.textColor = .secondaryText
        startTimeLabel.textAlignment = .center
        startTimeLabel.text = viewModel.formattedStartTime
        
        dividerView.backgroundColor = .secondaryText
        
        teamsVerticalStackView.axis = .vertical
        teamsVerticalStackView.spacing = 4
    }
    
    override func setupConstraints() {
        
        teamsVerticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(dividerView.snp.trailing).offset(16)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
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
