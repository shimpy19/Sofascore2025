//
//  EventCell.swift
//  Sofa
//
//  Created by Akademija on 28.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class RoundCell: UITableViewCell,BaseViewProtocol {

    static let reuseIdentifier = "EventCell"

    private let roundEventView = RoundEventView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
        styleViews()
    }
    func addViews() {
        contentView.addSubview(roundEventView)
    }
    func setupConstraints() {
        roundEventView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    func styleViews() {
        selectionStyle = .default
    }
        
        


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: RoundEventViewModel) {
        roundEventView.update(with: viewModel)
    }
}
