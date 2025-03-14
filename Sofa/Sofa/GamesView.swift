
import SofaAcademic


import UIKit
import SnapKit

class GamesView: BaseView {

    private let stackView = UIStackView()

    init(events: [Event]) {
        super.init()
        setupEvents(events)
    }

    private func setupEvents(_ events: [Event]) {
        for event in events {
            let eventView = EventView(event: event)
            stackView.addArrangedSubview(eventView)
        }
    }

    override func addViews() {
        addSubview(stackView)
    }

    override func styleViews() {
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
    }

    override func setupConstraints() {
            stackView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview()
        }
    }
    
    override func setupGestureRecognizers() {
        // Ovdje možete dodati gesture recognizere ako su potrebni
    }

    override func setupBinding() {
        // Ovdje možete postaviti bindings ako koristite neki reactive framework
    }
    
}
