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

            leagueView.snp.makeConstraints {
                $0.top.equalTo(192)
                $0.height.equalTo(56)
                $0.leading.trailing.equalToSuperview()
            }


            let gamesView = GamesView( events: events)
            self.view.addSubview(gamesView)

            gamesView.snp.makeConstraints {
                $0.top.equalTo(leagueView.snp.bottom)
                $0.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
}
