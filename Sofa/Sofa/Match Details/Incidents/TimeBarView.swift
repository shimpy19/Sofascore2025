//
//  TimeBarView.swift
//  Sofa
//
//  Created by Akademija on 20.06.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class TimeBarView: BaseView {
    private let backgroundSquare = UIView()
    private let timeLabel = UILabel()
    
    override func addViews() {
        addSubview(backgroundSquare)
        addSubview(timeLabel)
    }
    
    override func styleViews() {
        backgroundColor = .background
        
        timeLabel.font = .bold12
        
        backgroundSquare.backgroundColor = .standings
        backgroundSquare.layer.cornerRadius = 12
        backgroundSquare.clipsToBounds = true
        
    }
    
    override func setupConstraints() {
        backgroundSquare.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(24)
        }
        timeLabel.snp.makeConstraints {
            $0.center.equalTo(backgroundSquare)
        }
    }
    
    func update(with viewModel: TimeBarViewModel) {
        timeLabel.text = viewModel.timeText
    }
    
}
