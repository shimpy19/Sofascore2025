//
//  EventTeamView.swift
//  Sofa
//
//  Created by Akademija on 18.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class RoundEventTeamView: BaseView {

    private let teamLogoImageView = UIImageView()
    private let teamNameLabel = UILabel()
    private let teamScoreLabel = UILabel()
    
    override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func addViews() {
        addSubview(teamLogoImageView)
        addSubview(teamNameLabel)
        addSubview(teamScoreLabel)
    }

    override func styleViews() {
        teamLogoImageView.contentMode = .scaleAspectFit

        teamNameLabel.font = .regular14
        teamNameLabel.textColor = .primaryText

        teamScoreLabel.font = .regular14
    }

    override func setupConstraints() {
        teamLogoImageView.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.leading.top.bottom.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        teamNameLabel.snp.makeConstraints {
            $0.leading.equalTo(teamLogoImageView.snp.trailing).offset(8)
            $0.top.bottom.equalToSuperview()
        }

        teamScoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview()
        }
    }

    func update(with viewModel: EventTeamViewModel) {
        teamNameLabel.text = viewModel.name
        teamScoreLabel.text = viewModel.score
        teamScoreLabel.textColor = viewModel.scoreColor
        teamLogoImageView.setImage(with: viewModel.logoUrl)

    }
}
