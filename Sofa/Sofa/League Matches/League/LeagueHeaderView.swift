//
//  LeagueHeaderView.swift
//  Sofa
//
//  Created by Akademija on 28.03.2025..
//
import UIKit
import SnapKit
import SofaAcademic

class LeagueHeaderView: UITableViewHeaderFooterView {

    static let reuseIdentifier = "LeagueHeaderView"

    private let leagueView = LeagueView()

    var league: League? {
        didSet {
            if let league = league {
                leagueView.update(with: league)
            }
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leagueView)
        leagueView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
