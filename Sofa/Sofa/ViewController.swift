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

            let leagueView = LeagueView(laLigaLeague: laLigaLeague)
            self.view.addSubview(leagueView)

            leagueView.snp.makeConstraints { make in
                make.top.equalTo(192)
                make.height.equalTo(56)
                make.width.equalToSuperview()
            }


            let gamesView = GamesView( events: events)
            self.view.addSubview(gamesView)

            gamesView.snp.makeConstraints { make in
                make.top.equalTo(leagueView.snp.bottom)
                make.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
}
