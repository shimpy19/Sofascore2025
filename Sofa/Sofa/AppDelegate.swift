//
//  AppDelegate.swift
//  Sofa
//
//  Created by Akademija on 11.03.2025..
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let isLoggedIn = UserDefaults.standard.string(forKey: "username") != nil
        let rootVC = isLoggedIn ? MainEventsViewController() : LoginViewController()

        let mainWindow = UIWindow(frame: UIScreen.main.bounds)
        AppManager.shared.showScreen(in: mainWindow, viewController: rootVC)
        self.window = mainWindow

        return true
    }

}
