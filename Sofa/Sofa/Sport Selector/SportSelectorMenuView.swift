//
//  SportSelectorMenuView.swift
//  Sofa
//
//  Created by Akademija on 21.03.2025..
//
import UIKit
import SnapKit
import SofaAcademic
class SportSelectorMenuView: BaseView {

    private let sports: [Sport] = [.football, .basketball, .americanFootball]
    private let stackView = UIStackView()
    private let whiteBarView = UIView()
    private var selectedSportView: SportView?

    override func addViews() {
        addSubview(stackView)
        addSubview(whiteBarView)

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually

        sports.forEach { sport in
            let sportView = SportView(sport: sport)
            stackView.addArrangedSubview(sportView)
        }
    }

    override func styleViews() {
        backgroundColor = .sofaBlue

        whiteBarView.backgroundColor = .white
        whiteBarView.layer.cornerRadius = 2
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        whiteBarView.snp.makeConstraints { make in
            make.height.equalTo(4)
            make.bottom.equalToSuperview()
            make.width.equalTo(104)
            make.centerX.equalTo(stackView.arrangedSubviews.first!.snp.centerX)
        }
    }

    override func setupGestureRecognizers() {
        stackView.arrangedSubviews.forEach { view in
            guard let sportView = view as? SportView else { return }
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSportTap(_:)))
            sportView.addGestureRecognizer(tapGesture)
            sportView.isUserInteractionEnabled = true
        }
    }

    @objc private func handleSportTap(_ sender: UITapGestureRecognizer) {
        guard let tappedSportView = sender.view as? SportView else { return }

        selectedSportView = tappedSportView

        UIView.animate(withDuration: 0.3) {
            self.whiteBarView.snp.remakeConstraints { make in
                make.height.equalTo(4)
                make.bottom.equalToSuperview()
                make.width.equalTo(104)
                make.centerX.equalTo(tappedSportView.snp.centerX)
            }
            self.layoutIfNeeded()
        }
    }
}
