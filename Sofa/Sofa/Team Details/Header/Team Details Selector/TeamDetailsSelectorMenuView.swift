//
//  SportSelectorMenuView.swift
//  Sofa
//
//  Created by Akademija on 21.03.2025..
//
import UIKit
import SnapKit
import SofaAcademic

class TeamDetailsSelectorMenuView: BaseView {

    private let teamDetail: [TeamDetails] = [.details, .squad]
    private let horizontalStackView = UIStackView()
    private let indicatorView = UIView()

    private var selectedTeamDetailsView: TeamDetailsView?
    var onTeamDetailSelected: ((TeamDetails) -> Void)?

    override init() {
        super.init()
    }

    override func addViews() {
        addSubview(horizontalStackView)
        addSubview(indicatorView)

        teamDetail.forEach { detail in
            let view = TeamDetailsView(teamDetail: detail)
            if detail == .details {
                selectedTeamDetailsView = view
            }
            horizontalStackView.addArrangedSubview(view)
        }
    }

    override func styleViews() {
        backgroundColor = .sofaBlue

        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fillEqually

        indicatorView.backgroundColor = .background
        indicatorView.layer.cornerRadius = 2
    }

    override func setupConstraints() {

        horizontalStackView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(indicatorView.snp.top).offset(8)
        }

        if let first = horizontalStackView.arrangedSubviews.first {
            indicatorView.snp.makeConstraints {
                $0.top.equalTo(horizontalStackView.snp.bottom)
                $0.height.equalTo(4)
                $0.width.equalTo(first.snp.width).multipliedBy(0.8)
                $0.centerX.equalTo(first.snp.centerX)
                $0.bottom.equalToSuperview()
            }
        }
    }

    override func setupGestureRecognizers() {
        horizontalStackView.arrangedSubviews.forEach { view in
            guard let detailView = view as? TeamDetailsView else { return }
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            detailView.addGestureRecognizer(tapGesture)
            detailView.isUserInteractionEnabled = true
        }
    }

    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        guard let tapped = sender.view as? TeamDetailsView else { return }

        selectedTeamDetailsView = tapped

        UIView.animate(withDuration: 0.3) {
            self.indicatorView.snp.remakeConstraints { make in
                make.top.equalTo(self.horizontalStackView.snp.bottom)
                make.height.equalTo(4)
                make.width.equalTo(tapped.snp.width).multipliedBy(0.8)
                make.centerX.equalTo(tapped.snp.centerX)
                make.bottom.equalToSuperview()
            }
            self.layoutIfNeeded()
        }

        onTeamDetailSelected?(tapped.teamDetail)
    }
}
