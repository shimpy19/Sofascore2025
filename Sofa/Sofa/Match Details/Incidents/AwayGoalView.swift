//
//  AwayGoalView.swift
//  Sofa
//
//  Created by Akademija on 20.06.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class AwayGoalView: BaseView {
    private let iconImageView = UIImageView()
    private let minuteLabel = UILabel()
    private let playerLabel = UILabel()
    private let dividerView = UIView()
    private let scoreLabel = UILabel()
    
    override func addViews() {
        addSubview(iconImageView)
        addSubview(minuteLabel)
        addSubview(playerLabel)
        addSubview(dividerView)
        addSubview(scoreLabel)
    }
    
    override func styleViews() {
        backgroundColor = .background
        
        iconImageView.contentMode = .scaleAspectFit
        
        minuteLabel.font = .regular12
        minuteLabel.textColor = .secondaryText
        
        playerLabel.font = .regular14
        playerLabel.textColor = .primaryText
        
        dividerView.backgroundColor = .secondaryText
        
        scoreLabel.font = .bold20
        scoreLabel.textColor = .primaryText
        
    }
    
    override func setupConstraints() {
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(minuteLabel.snp.top).offset(-4)
            $0.top.equalToSuperview().offset(8)
        }
        minuteLabel.snp.makeConstraints {
            $0.centerX.equalTo(iconImageView)
            $0.top.equalTo(iconImageView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().offset(-8)
        }
        dividerView.snp.makeConstraints {
            $0.trailing.equalTo(iconImageView.snp.leading).offset(-16)
            $0.width.equalTo(1)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        playerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        scoreLabel.snp.makeConstraints {
            $0.trailing.equalTo(dividerView.snp.leading).offset(-16)
            $0.bottom.top.equalToSuperview().inset(8)
        }
    }
    
    func update(with viewModel: IncidentViewModel) {
        let iconImage = UIImage(named: viewModel.iconName)?.withRenderingMode(.alwaysTemplate)
        iconImageView.image = iconImage
        iconImageView.tintColor = viewModel.tintColor
        minuteLabel.text = viewModel.minuteText
        playerLabel.text = viewModel.player
        scoreLabel.text = viewModel.score
    }

}



