//
//  HomeGoalCell.swift
//  Sofa
//
//  Created by Akademija on 20.06.2025..
//

import UIKit

class HomeGoalCell: UITableViewCell {
    static let reuseIdentifier = "HomeGoalCell"
    private let incidentView = HomeGoalView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(incidentView)
        incidentView.snp.makeConstraints { $0.edges.equalToSuperview() }
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) { fatalError() }

    func update(with viewModel: IncidentViewModel) {
        incidentView.update(with: viewModel)
    }
}



