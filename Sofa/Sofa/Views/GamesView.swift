
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
            let eventView = EventView(viewModel: EventViewModel(event: event))
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
            stackView.snp.makeConstraints {
                $0.leading.trailing.top.equalToSuperview()
                $0.bottom.equalToSuperview()
        }
    }
        
}
