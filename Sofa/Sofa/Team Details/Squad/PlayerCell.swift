//
//  PlayerCell.swift
//  Sofa
//
//  Created by Akademija on 18.06.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class PlayerCell: UITableViewCell, BaseViewProtocol {

    static let reuseIdentifier = "PlayerCell"

    private let playerView = PlayerView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
        styleViews()
    }

    func addViews() {
        contentView.addSubview(playerView)
    }

    func setupConstraints() {
        playerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
    }

    func styleViews() {
        selectionStyle = .none
        backgroundColor = .clear
    }

    func update(with player: Player) {
        playerView.update(with: player)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


