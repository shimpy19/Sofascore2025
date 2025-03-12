//
//  ViewController.swift
//  Sofa
//
//  Created by Akademija on 11.03.2025..
//

import UIKit

class ViewController: UIViewController {
    private let customView = CustomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customView)
        
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }}

