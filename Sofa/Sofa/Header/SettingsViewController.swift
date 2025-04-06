//
//  SettingsViewController.swift
//  Sofa
//
//  Created by Akademija on 04.04.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class SettingsViewController: UIViewController,BaseViewProtocol {

    private let dismissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        view.backgroundColor = .backgroundMain
        
        title = "Settings"
    }
    
    func addViews() {
        
    }
    func setupConstraints() {
    }
}

