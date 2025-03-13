//
//  ViewController.swift
//  Sofa
//
//  Created by Akademija on 11.03.2025..
//

import UIKit
import SofaAcademic
import SnapKit

class ViewController: UIViewController {

    var dataSource = Homework2DataSource()
    var laLigaLeague: League?
    var events: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        laLigaLeague = dataSource.laLigaLeague()
        events = dataSource.laLigaEvents()

        if let laLigaLeague = laLigaLeague {

            let customView = CustomView(laLigaLeague: laLigaLeague)
            self.view.addSubview(customView)

            customView.snp.makeConstraints { make in
                make.top.equalTo(192)
                make.height.equalTo(56)
                make.width.equalToSuperview()
            }


            let customView2 = CustomView2(laLigaLeague: laLigaLeague, events: events)
            self.view.addSubview(customView2)

            customView2.snp.makeConstraints { make in
                make.top.equalTo(customView.snp.bottom)
                make.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
}
