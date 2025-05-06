//
//  AppManager.swift
//  Sofa
//
//  Created by Akademija on 30.04.2025..
//
import UIKit

enum AppManager {
    static let shared = AppManager()

    private init() {}

    func showScreen(in window: UIWindow, viewController: UIViewController) {
        let navVC = UINavigationController(rootViewController: viewController)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }

}

