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
    private let headerViewModel: HeaderDetailsViewModel
    private let headerView = HeaderDetailsView()
    private let backButton = UIButton(type: .system)
    private let safeAreaFillView = UIView()

    init(event: Event, sport: Sport) {
        self.viewModel = EventDetailsViewModel(event: event)
        self.headerViewModel = HeaderDetailsViewModel(event: event, sport: sport)
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
        styleViews()
    }

    func addViews() {
        view.addSubview(matchView)
        view.addSubview(safeAreaFillView)
    }

    func setupConstraints() {
        matchView.snp.makeConstraints {
            $0.height.equalTo(112)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        safeAreaFillView.snp.makeConstraints {
            $0.bottom.equalTo(matchView.snp.top)
            $0.leading.trailing.top.equalToSuperview()
        }
    }

    func styleViews() {
        matchView.update(with: viewModel)
        
        headerView.configure(with: headerViewModel)
        navigationItem.titleView = headerView
        
        safeAreaFillView.backgroundColor = .background
        
        backButton.setImage(UIImage(named: "ic_backarrow"), for: .normal)
        backButton.tintColor = .primaryText
        backButton.semanticContentAttribute = .forceLeftToRight
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }

}
