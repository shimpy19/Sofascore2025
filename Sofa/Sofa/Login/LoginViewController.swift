//
//  LoginViewController.swift
//  Sofa
//
//  Created by Akademija on 14.04.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class LoginViewController: UIViewController {

    private let loginView = LoginView()

    override func loadView() {
        self.view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginViewDidTapLogin(_ loginView: LoginView, username: String, password: String) {
        Task {
            do {
                let response = try await APIClient.login(username: username, password: password)
                try TokenStorage.save(token: response.token)
                UserDefaults.standard.set(response.name, forKey: "username")
                self.openMainEvents()
            } catch {
                print("Login failed: \(error)")
            }
        }
    }
    private func openMainEvents() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }

        let mainVC = MainEventsViewController()
        let navVC = UINavigationController(rootViewController: mainVC)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
}


