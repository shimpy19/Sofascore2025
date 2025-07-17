//
//  StartingView.swift
//  Sofa
//
//  Created by Akademija on 20.06.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class StartingView: BaseView {
    private let backgroundSquare = UIView()
    private let startingLabel = UILabel()
    
    override func addViews() {
        addSubview(backgroundSquare)
        addSubview(startingLabel)
    }
    
    override func styleViews() {
        backgroundColor = .background
        
        startingLabel.text = "No results yet."
        startingLabel.font = .regular14
        startingLabel.textColor = .secondaryText
        
        backgroundSquare.backgroundColor = .backgroundMain
        backgroundSquare.layer.cornerRadius = 12
        backgroundSquare.clipsToBounds = true
        
    }
    
    override func setupConstraints() {
        backgroundSquare.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(52)
        }
        startingLabel.snp.makeConstraints {
            $0.center.equalTo(backgroundSquare)
        }
    }
}
        
            
        
        
        
        


