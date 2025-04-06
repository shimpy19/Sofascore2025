//
//  MatchDetailsViewController.swift
//  Sofa
//
//  Created by Akademija on 04.04.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class MatchDetailsViewController: UIViewController, BaseViewProtocol {

    private let matchView = EventDetailsView()
    private let viewModel: EventDetailsViewModel

    init(event: Event) {
        self.viewModel = EventDetailsViewModel(event: event)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundMain
        addViews()
        setupConstraints()
        
        matchView.update(with: viewModel)

        title = "Match Details"
    }
    func addViews() {
        view.addSubview(matchView)
    }
    func setupConstraints() {
        matchView.snp.makeConstraints {
            $0.height.equalTo(112)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
