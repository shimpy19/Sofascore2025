//
//  SportView.swift
//  Sofa
//
//  Created by Akademija on 22.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic


class LeagueDetailsView: BaseView {
    
    private let barLabel = UILabel()
    let leagueDetail: LeagueDetails

     init(leagueDetail: LeagueDetails) {
         self.leagueDetail = leagueDetail
         super.init()
    }

    override func addViews() {
        addSubview(barLabel)
    }

    override func styleViews() {
        
        
        barLabel.text = leagueDetail.title
        
        barLabel.numberOfLines = 1
        barLabel.lineBreakMode = .byTruncatingTail
        barLabel.font = .regular14
        barLabel.textColor = .background
        barLabel.textAlignment = .center
    }

    override func setupConstraints() {

        barLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(16)
        }
            
    }


}
