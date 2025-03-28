//
//  EventCell.swift
//  Sofa
//
//  Created by Akademija on 28.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class EventCell: UITableViewCell {

    static let reuseIdentifier = "EventCell"

    private let eventView = EventView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(eventView)
        eventView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: EventViewModel) {
        eventView.update(with: viewModel)
    }
}
