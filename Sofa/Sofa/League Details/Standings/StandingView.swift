//
//  StandingView.swift
//  Sofa
//
//  Created by Akademija on 12.06.2025..
//
import UIKit
import SnapKit
import SofaAcademic

class StandingView: BaseView {

    private let circleView = UIView()
    private let standingLabel = UILabel()
    private let teamNameLabel = UILabel()
    private let horizontalStackView = UIStackView()

    private var columnLabels: [UILabel] = []

    override init() {
        super.init()
    }

    override func addViews() {
        addSubview(circleView)
        addSubview(standingLabel)
        addSubview(teamNameLabel)
        addSubview(horizontalStackView)
    }

    override func styleViews() {
        backgroundColor = .background

        [standingLabel, teamNameLabel].forEach {
            $0.font = .regular14
            $0.textColor = .primaryText
        }

        circleView.backgroundColor = .standings
        circleView.layer.cornerRadius = 12

        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 8
        horizontalStackView.distribution = .fill
    }

    override func setupConstraints() {
        circleView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        standingLabel.snp.makeConstraints {
            $0.center.equalTo(circleView)
        }

        teamNameLabel.snp.makeConstraints {
            $0.leading.equalTo(circleView.snp.trailing).offset(8)
            $0.centerY.equalTo(circleView)
        }

        horizontalStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalTo(circleView)
            $0.leading.greaterThanOrEqualTo(teamNameLabel.snp.trailing).offset(8)
        }
    }

    func update(with viewModel: StandingViewModel) {
        standingLabel.text = viewModel.standingText
        teamNameLabel.text = viewModel.teamName

        columnLabels.forEach { $0.removeFromSuperview() }
        horizontalStackView.arrangedSubviews.forEach { horizontalStackView.removeArrangedSubview($0); $0.removeFromSuperview() }

        columnLabels = viewModel.columns.map { column in
            let wrapper = UIView()
            let label = UILabel()
            label.font = .regular14
            label.textColor = .primaryText
            label.textAlignment = .center
            label.text = viewModel[keyPath: column.keyPath]

            wrapper.addSubview(label)
            label.snp.makeConstraints { $0.edges.equalToSuperview() }
            wrapper.snp.makeConstraints { $0.width.equalTo(column.width) }

            horizontalStackView.addArrangedSubview(wrapper)
            return label
        }
    }
}
