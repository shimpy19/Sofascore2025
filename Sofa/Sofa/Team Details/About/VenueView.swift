//
//  VenueView.swift
//  Sofa
//
//  Created by Akademija on 17.06.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class VenueView: BaseView {
    
    private let venueLabel = UILabel()
    private let stadiumLabel = UILabel()
    private let stadiumNameLabel = UILabel()
    
    override init() {
        super.init()
    }
    
    override func addViews() {
        addSubview(venueLabel)
        addSubview(stadiumLabel)
        addSubview(stadiumNameLabel)
    }
    
    override func styleViews() {
        
        backgroundColor = .background
        venueLabel.text = "Venue"
        venueLabel.font = .bold16
        venueLabel.textColor = .primaryText
        
        stadiumLabel.text = "Stadium"
        stadiumLabel.font = .regular14
        stadiumLabel.textColor = .primaryText
        
        stadiumNameLabel.font = .regular14
        stadiumNameLabel.textColor = .primaryText
        
    }
    
    override func setupConstraints() {
        
        venueLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            
        }
        
        stadiumLabel.snp.makeConstraints {
            $0.top.equalTo(venueLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        stadiumNameLabel.snp.makeConstraints {
            $0.top.equalTo(venueLabel.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
    }
    
    func update(with teamInfo: TeamInfo) {
        stadiumNameLabel.text = teamInfo.venue.name
    }
    
}
    
    
    
            
            

        
        
        
        
    

