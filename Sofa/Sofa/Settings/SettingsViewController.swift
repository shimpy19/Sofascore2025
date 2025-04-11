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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        styleViews()
    }
    
    func addViews() {
        
    }
    func setupConstraints() {
    }
    func styleViews() {
        view.backgroundColor = .backgroundMain
        
        title = "Settings"
    }
}

