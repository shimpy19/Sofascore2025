//
//  IncidentView.swift
//  Sofa
//
//  Created by Akademija on 19.06.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class HomeIncidentView: BaseView {
    private let iconImageView = UIImageView()
    private let minuteLabel = UILabel()
    private let playerLabel = UILabel()
    private let dividerView = UIView()
    private let descriptionLabel = UILabel()
    
    override func addViews() {
        addSubview(iconImageView)
        addSubview(minuteLabel)
        addSubview(playerLabel)
        addSubview(dividerView)
        addSubview(descriptionLabel)
    }
    
    override func styleViews() {
        backgroundColor = .background
        
        iconImageView.contentMode = .scaleAspectFit
        
        minuteLabel.font = .regular12
        minuteLabel.textColor = .secondaryText
        
        playerLabel.font = .regular14
        playerLabel.textColor = .primaryText
        
        dividerView.backgroundColor = .secondaryText
        
        descriptionLabel.font = .regular12
        descriptionLabel.textColor = .secondaryText
        
    }
    
    override func setupConstraints() {
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(minuteLabel.snp.top).offset(-4)
            $0.top.equalToSuperview().offset(8)
        }
        minuteLabel.snp.makeConstraints {
            $0.centerX.equalTo(iconImageView)
            $0.top.equalTo(iconImageView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().offset(-8)
        }
        dividerView.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(16)
            $0.width.equalTo(1)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        playerLabel.snp.makeConstraints {
            $0.leading.equalTo(dividerView.snp.trailing).offset(12)
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalTo(descriptionLabel.snp.top)
        }
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(playerLabel)
            $0.bottom.equalToSuperview().offset(-12)
            $0.top.equalTo(playerLabel.snp.bottom)
        }
    }
    
    func update(with viewModel: IncidentViewModel) {
        let iconImage = UIImage(named: viewModel.iconName)?.withRenderingMode(.alwaysTemplate)
        iconImageView.image = iconImage
        iconImageView.tintColor = viewModel.tintColor
        minuteLabel.text = viewModel.minuteText
        playerLabel.text = viewModel.player
        descriptionLabel.text = viewModel.description
    }

}

