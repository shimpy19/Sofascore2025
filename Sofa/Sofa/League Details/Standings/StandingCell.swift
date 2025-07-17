//
//  StandingsCell.swift
//  Sofa
//
//  Created by Akademija on 12.06.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class StandingCell: UITableViewCell, BaseViewProtocol {

    static let reuseIdentifier = "StandingCell"

    private let standingView = StandingView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
        styleViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        contentView.addSubview(standingView)
    }

    func setupConstraints() {
        standingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func styleViews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    func configure(with viewModel: StandingViewModel) {
        standingView.update(with: viewModel)
    }
}

