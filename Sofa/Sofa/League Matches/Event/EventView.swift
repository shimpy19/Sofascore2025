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

    private let homeTeamView = EventTeamView()
    private let awayTeamView = EventTeamView()
    private let timeLabel = UILabel()
    private let dividerView = DividerView()
    private let startTimeLabel = UILabel()
    private let teamsVerticalStackView = UIStackView()

    private var viewModel: EventViewModel?
    
    override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func addViews() {
        teamsVerticalStackView.addArrangedSubview(homeTeamView)
        teamsVerticalStackView.addArrangedSubview(awayTeamView)
        addSubview(teamsVerticalStackView)
        addSubview(timeLabel)
        addSubview(dividerView)
        addSubview(startTimeLabel)
    }

    override func styleViews() {
        backgroundColor = .background

        timeLabel.font = .regular12
        timeLabel.textAlignment = .center

        startTimeLabel.font = .regular12
        startTimeLabel.textColor = .secondaryText
        startTimeLabel.textAlignment = .center

        dividerView.backgroundColor = .secondaryText

        teamsVerticalStackView.axis = .vertical
        teamsVerticalStackView.spacing = 4
    }

    override func setupConstraints() {
        teamsVerticalStackView.snp.makeConstraints {
            $0.leading.equalTo(dividerView.snp.trailing).offset(16)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview()
        }

        dividerView.snp.makeConstraints {
            $0.leading.equalTo(startTimeLabel.snp.trailing).offset(4)
            $0.width.equalTo(1)
            $0.top.bottom.equalToSuperview().inset(10)
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

    func update(with viewModel: EventViewModel) {
        self.viewModel = viewModel
        timeLabel.textColor = viewModel.timeColor
        timeLabel.text = viewModel.timeText
        startTimeLabel.text = viewModel.formattedStartTime
        homeTeamView.update(with: viewModel.homeTeamViewModel)
        awayTeamView.update(with: viewModel.awayTeamViewModel)
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
