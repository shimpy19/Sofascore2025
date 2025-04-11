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

    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let stackView = UIStackView()

    override func addViews() {
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(titleLabel)
        addSubview(stackView)
    }

    override func styleViews() {
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center

        logoImageView.contentMode = .scaleAspectFit

        titleLabel.textColor = .secondaryText
        titleLabel.font = .regular12
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { $0.size.equalTo(16) }
    }

    func configure(with viewModel: HeaderDetailsViewModel) {
        if let urlString = viewModel.logoUrl, let url = URL(string: urlString) {
            logoImageView.loadImage(from: url)
        }
        titleLabel.text = viewModel.titleText
    }
}
