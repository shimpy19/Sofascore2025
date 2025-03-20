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
    
    private let teamLogoImageView = UIImageView()
    private let teamNameLabel = UILabel()
    
    private let team: Team
    private let event: Event
    
    init(team: Team, event: Event) {
        self.team = team
        self.event = event
        super.init()
    }
    
    override func addViews() {
        addSubview(teamLogoImageView)
        addSubview(teamNameLabel)
    }
    
    override func styleViews() {
        teamLogoImageView.contentMode = .scaleAspectFit
        
        teamNameLabel.font = .regular14
        teamNameLabel.textColor = .primaryText
        
        if let logoUrl = team.logoUrl, let url = URL(string: logoUrl) {
            teamLogoImageView.loadImage(from: url)
        }
        
        teamNameLabel.text = team.name
    }
    
    override func setupConstraints() {
        teamLogoImageView.snp.makeConstraints {
            $0.size.equalTo(16)
        }
        
        teamNameLabel.snp.makeConstraints {
            $0.leading.equalTo(teamLogoImageView.snp.trailing).offset(8)
            $0.height.equalTo(16)
            
        }
        self.snp.makeConstraints {
            $0.height.equalTo(16)
            
        }
    }
}
