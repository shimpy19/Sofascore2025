//
//  SettingsView.swift
//  Sofa
//
//  Created by Akademija on 16.04.2025..
//
import UIKit
import SnapKit
import SofaAcademic

class SettingsView: BaseView {
    private let userLabel = UILabel()
    private let countLabel = UILabel()
    private let loguoutButton = UIButton()

    override func addViews() {
        addSubview(userLabel)
        addSubview(countLabel)
        addSubview(loguoutButton)
    }

    override func styleViews() {
        let name = UserDefaults.standard.string(forKey: "username") ?? "Guest"
        userLabel.text = "Hello, \(name)!"
        userLabel.font = .bold14
        userLabel.textColor = .primaryText
        userLabel.textAlignment = .center

        let eventCount = DatabaseManager.shared.countEvents()
        let leagueCount = DatabaseManager.shared.countLeagues()
        countLabel.text = "Events: \(eventCount)   Leagues: \(leagueCount)"
        countLabel.font = .regular14
        countLabel.textColor = .secondaryText
        countLabel.textAlignment = .center

        loguoutButton.setTitle("Logout", for: .normal)
        loguoutButton.setTitleColor(.white, for: .normal)
        loguoutButton.backgroundColor = .sofaBlue
        loguoutButton.layer.cornerRadius = 8
        loguoutButton.titleLabel?.font = .bold14
        loguoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }

    override func setupConstraints() {
        userLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }

        countLabel.snp.makeConstraints {
            $0.top.equalTo(userLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }

        loguoutButton.snp.makeConstraints {
            $0.top.equalTo(countLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(40)
        }
    }

    @objc private func logoutTapped() {
        UserDefaults.standard.removeObject(forKey: "username")
        TokenStorage.clear()
        DatabaseManager.shared.deleteAll()

        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }

        let loginVC = LoginViewController()
        let navVC = UINavigationController(rootViewController: loginVC)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
}
