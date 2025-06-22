//
//  CoachView.swift
//  Sofa
//
//  Created by Akademija on 18.06.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class CoachView: BaseView {
    
    private let coachImageView = UIImageView()
    private let coachNameLabel = UILabel()
    private let coachCountryLabel = UILabel()
    private let coachLabel = UILabel()
    
    override init() {
        super.init()
    }
    
    override func addViews() {
        addSubview(coachImageView)
        addSubview(coachNameLabel)
        addSubview(coachCountryLabel)
        addSubview(coachLabel)
    }
    
    override func styleViews() {
        
        backgroundColor = .background
        
        coachLabel.font = .bold14
        coachLabel.textColor = .primaryText
        coachLabel.text = "Coach"
        
        coachImageView.contentMode = .scaleAspectFill
        coachImageView.clipsToBounds = true
        coachImageView.layer.cornerRadius = 20
        
        coachNameLabel.font = .regular14
        coachNameLabel.textColor = .primaryText
        
        coachCountryLabel.font = .bold12
        coachCountryLabel.textColor = .secondaryText
        
    }
    
    override func setupConstraints() {
        
        coachLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(24)
        }
        
        coachImageView.snp.makeConstraints {
            $0.top.equalTo(coachLabel.snp.bottom).offset(16)
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
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func update(with teamInfo: TeamInfo) {
        coachImageView.setImage(with: teamInfo.manager.imageUrl)
        coachNameLabel.text = "Coach: \(teamInfo.manager.name)"
        coachCountryLabel.text = teamInfo.manager.country.name
    }
    
}
    
    

    
        
        
    
    

