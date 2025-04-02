//
//  LeagueHeaderView.swift
//  Sofa
//
//  Created by Akademija on 28.03.2025..
//
import UIKit
import SnapKit
import SofaAcademic

class LeagueHeaderView: UITableViewHeaderFooterView,BaseViewProtocol {

    static let reuseIdentifier = "LeagueHeaderView"

    private let leagueView = LeagueView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }
    func addViews() {
        contentView.addSubview(leagueView)
    }
    func setupConstraints() {
        leagueView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
        
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with league: League) {
        leagueView.update(with: league)
    }

}
