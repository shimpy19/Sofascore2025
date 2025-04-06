//
//  HeaderView.swift
//  Sofa
//
//  Created by Akademija on 04.04.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class HeaderView: BaseView {

    private let sofaLogoImageView = UIImageView()
    private let settingsButton = UIButton()
    private let titleIconImageView = UIImageView()

    var onSettingsTapped: (() -> Void)?

    override func addViews() {
        addSubview(sofaLogoImageView)
        addSubview(settingsButton)
        addSubview(titleIconImageView)
    }

    override func styleViews() {
        backgroundColor = .sofaBlue
        titleIconImageView.contentMode = .scaleAspectFit
        titleIconImageView.image = UIImage(named: "ic_title")

        sofaLogoImageView.contentMode = .scaleAspectFit
        sofaLogoImageView.image = UIImage(named: "ic_sofascore")

        settingsButton.setImage(UIImage(named: "ic_settings"), for: .normal)
    }

    override func setupConstraints() {
        sofaLogoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.top.equalToSuperview().inset(14)
            $0.width.equalTo(120)
            $0.height.equalTo(20)
        }

        settingsButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }

        titleIconImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.size.equalTo(20)
            $0.trailing.equalTo(settingsButton.snp.leading).offset(-24)
        }
    }

    override func setupGestureRecognizers() {
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
    }

    @objc private func settingsTapped() {
        onSettingsTapped?()
    }
}
