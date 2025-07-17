//
//  StandingsTemplateView.swift
//  Sofa
//
//  Created by Akademija on 12.06.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class StandingsTemplateView: BaseView {

    private let standingLabel = UILabel()
    private let teamNameLabel = UILabel()
    private let horizontalStackView = UIStackView()
    
    private var columnLabels: [UILabel] = []
    
    override init() {
        super.init()
    }

    override func addViews() {
        addSubview(standingLabel)
        addSubview(teamNameLabel)
        addSubview(horizontalStackView)
    }

    override func styleViews() {
        [standingLabel, teamNameLabel].forEach {
            $0.font = .regular14
            $0.textColor = .secondaryText
            $0.textAlignment = .center
        }
        backgroundColor = .background
        
        standingLabel.text = "#"
        teamNameLabel.text = "Team"
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fill
    }

    override func setupConstraints() {
        standingLabel.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(16)
        }
        teamNameLabel.snp.makeConstraints {
            $0.leading.equalTo(standingLabel.snp.trailing).offset(16)
            $0.top.bottom.equalToSuperview().inset(16)
        }
        horizontalStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.greaterThanOrEqualTo(teamNameLabel.snp.trailing).offset(8)
        }
    }

    func update(with model: StandingViewModel) {
        columnLabels.forEach { $0.removeFromSuperview() }
        columnLabels.removeAll()
        horizontalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for column in model.columns {
            let label = UILabel()
            label.font = .regular14
            label.textColor = .secondaryText
            label.textAlignment = .center
            label.text = column.title

            let wrapper = UIView()
            wrapper.addSubview(label)
            label.snp.makeConstraints { $0.edges.equalToSuperview() }

            wrapper.snp.makeConstraints { $0.width.equalTo(column.width) }

            horizontalStackView.addArrangedSubview(wrapper)
            columnLabels.append(label)
        }
    }
}

    
    
    
    
        
            
        

    
    


