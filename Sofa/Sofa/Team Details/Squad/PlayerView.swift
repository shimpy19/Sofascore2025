//
//  PlayerView.swift
//  Sofa
//
//  Created by Akademija on 18.06.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class PlayerView: BaseView {
    
    private let playerImageView = UIImageView()
    private let playerNameLabel = UILabel()
    private let playerCountryLabel = UILabel()
    
    override init() {
        super.init()
    }
    
    override func addViews() {
        addSubview(playerImageView)
        addSubview(playerNameLabel)
        addSubview(playerCountryLabel)
    }
    
    override func styleViews() {
        
        backgroundColor = .background
        
        playerImageView.contentMode = .scaleAspectFill
        playerImageView.clipsToBounds = true
        playerImageView.layer.cornerRadius = 20
        
        playerNameLabel.font = .regular14
        playerNameLabel.textColor = .primaryText
        
        playerCountryLabel.font = .bold12
        playerCountryLabel.textColor = .secondaryText
        
    }
    
    override func setupConstraints() {
        
        playerImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(40)
        }
        
        playerNameLabel.snp.makeConstraints {
            $0.top.equalTo(playerImageView.snp.top)
            $0.leading.equalTo(playerImageView.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
        
        playerCountryLabel.snp.makeConstraints {
            $0.top.equalTo(playerNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(playerNameLabel)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func update(with player: Player) {
        playerImageView.setImage(with: player.imageUrl)
        playerNameLabel.text = player.name
        playerCountryLabel.text = player.country.name
    }

    
}

