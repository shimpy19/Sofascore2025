//
//  ViewController.swift
//  Sofa
//
//  Created by Akademija on 11.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {
    
    let dataSource = Homework3DataSource()
    let sportSelectorMenu = SportSelectorMenuView()
    var leagueMatchesView: LeagueMatchesView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundMain
        view.addSubview(sportSelectorMenu)

        sportSelectorMenu.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }

        let allEvents = dataSource.events()
        var leagues: [League] = []
        var addedLeagues = Set<Int>() 

        for event in allEvents {
            if let league = event.league, !addedLeagues.contains(league.id) {
                leagues.append(league)
                addedLeagues.insert(league.id)
            }
        }

        leagueMatchesView = LeagueMatchesView(leagues: leagues, events: allEvents)
        
        if let leagueMatchesView = leagueMatchesView {
            view.addSubview(leagueMatchesView)
            leagueMatchesView.snp.makeConstraints {
                $0.top.equalTo(sportSelectorMenu.snp.bottom)
                $0.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
}
