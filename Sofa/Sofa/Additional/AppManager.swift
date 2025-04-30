//
//  AppManager.swift
//  Sofa
//
//  Created by Akademija on 30.04.2025..
//
import UIKit

final class AppManager {
    static let shared = AppManager()

    private init() {}

    func showMainScreen() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }

        let mainVC = MainEventsViewController()
        let navVC = UINavigationController(rootViewController: mainVC)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
    func showLoginScreen() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }

        let mainVC = LoginViewController()
        let navVC = UINavigationController(rootViewController: mainVC)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
    
    
}

