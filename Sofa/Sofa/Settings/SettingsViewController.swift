//
//  SettingsViewController.swift
//  Sofa
//
//  Created by Akademija on 04.04.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class SettingsViewController: UIViewController, BaseViewProtocol {
    private let settingsView = SettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleViews()
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        view.addSubview(settingsView)
    }
    func setupConstraints() {
        settingsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    func styleViews() {
        view.backgroundColor = .backgroundMain
        
        title = "Settings"
    }
}

