//
//  HeaderDetailsView.swift
//  Sofa
//
//  Created by Akademija on 11.04.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class HeaderDetailsView: BaseView {

    private let leagueLogoImageView = UIImageView()
    private let eventDataLabel = UILabel()
    private let stackView = UIStackView()

    override func addViews() {
        stackView.addArrangedSubview(leagueLogoImageView)
        stackView.addArrangedSubview(eventDataLabel)
        addSubview(stackView)
    }

    override func styleViews() {
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center

        leagueLogoImageView.contentMode = .scaleAspectFit

        eventDataLabel.textColor = .secondaryText
        eventDataLabel.font = .regular12
        eventDataLabel.numberOfLines = 1
        eventDataLabel.lineBreakMode = .byTruncatingTail
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        leagueLogoImageView.snp.makeConstraints { $0.size.equalTo(16) }
    }

    func configure(with viewModel: HeaderDetailsViewModel) {
        if let urlString = viewModel.logoUrl, let url = URL(string: urlString) {
            leagueLogoImageView.loadImage(from: url)
        }
        eventDataLabel.text = viewModel.titleText
    }
}
