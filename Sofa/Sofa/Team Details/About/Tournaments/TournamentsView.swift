//
//  TournamentsView.swift
//  Sofa
//
//  Created by Akademija on 17.06.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class TournamentsView: BaseView {

    private let titleLabel = UILabel()
    private let verticalStack = UIStackView()

    override func addViews() {
        addSubview(titleLabel)
        addSubview(verticalStack)
    }

    override func styleViews() {
        backgroundColor = .background
        titleLabel.text = "Tournaments"
        titleLabel.font = .bold16

        verticalStack.axis = .vertical
        verticalStack.spacing = 12
        verticalStack.alignment = .fill
        verticalStack.distribution = .fillEqually
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }

        verticalStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }

    func update(with tournaments: [League]) {
        verticalStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let groups = stride(from: 0, to: tournaments.count, by: 3).map {
            Array(tournaments[$0..<min($0 + 3, tournaments.count)])
        }

        for group in groups {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.spacing = 12
            horizontalStack.distribution = .fillEqually

            group.forEach { league in
                let view = TournamentItemView()
                view.update(with: league)
                horizontalStack.addArrangedSubview(view)
            }
            let missing = 3 - group.count
            for _ in 0..<missing {
                horizontalStack.addArrangedSubview(UIView())
            }

            verticalStack.addArrangedSubview(horizontalStack)
        }
    }
}
