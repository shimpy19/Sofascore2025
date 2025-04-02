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
    private let horizontalStackView = UIStackView()
    private let indicatorView = UIView()
    private var selectedSportView: SportView?

    override func addViews() {
        addSubview(horizontalStackView)
        addSubview(indicatorView)

        sports.forEach { sport in
            let sportView = SportView(sport: sport)
            horizontalStackView.addArrangedSubview(sportView)
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
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }

        // Postavi indikator ispod prvog taba
        if let firstSportView = horizontalStackView.arrangedSubviews.first {
            indicatorView.snp.makeConstraints { make in
                make.top.equalTo(horizontalStackView.snp.bottom)
                make.height.equalTo(4)
                make.width.equalTo(firstSportView.snp.width).multipliedBy(0.8)
                make.centerX.equalTo(firstSportView.snp.centerX)
                make.bottom.equalToSuperview()
            }

            selectedSportView = firstSportView as? SportView
        }
    }

    override func setupGestureRecognizers() {
        horizontalStackView.arrangedSubviews.forEach { view in
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
            self.indicatorView.snp.remakeConstraints { make in
                make.top.equalTo(self.horizontalStackView.snp.bottom)
                make.height.equalTo(4)
                make.width.equalTo(tappedSportView.snp.width).multipliedBy(0.8)
                make.centerX.equalTo(tappedSportView.snp.centerX)
                make.bottom.equalToSuperview()
            }
            self.layoutIfNeeded()
        }
    }
}
