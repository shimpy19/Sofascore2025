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
    func loginTapHandler( username: String, password: String) {
        Task {
            do {
                let response = try await APIClient.login(username: username, password: password)
                try TokenStorage.save(token: response.token)
                UserDefaults.standard.set(response.name, forKey: "username")
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    AppManager.shared.showScreen(in: window, viewController: MainEventsViewController())
                }
            } catch {
                self.loginView.stopLoading(message: "Wrong username or password")
                print("Login failed: \(error)")
            }
        }
    }
}


