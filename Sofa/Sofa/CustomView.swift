import UIKit
import SnapKit
import SofaAcademic

//Ovaj CustomView je izgeneriran kako bi se isprobalo moze li se simulator pokrenuti normalno

class CustomView: BaseView {
    
    // UI elementi
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, Custom View!"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Tap me!", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func addViews() {
        // Dodajemo subview-ove u naš CustomView
        addSubview(titleLabel)
        addSubview(button)
    }

    override func styleViews() {
        // Stiliziramo naše subview-ove
        backgroundColor = .darkGray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }

    override func setupConstraints() {
        // Postavljanje SnapKit constraints-a
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }

    override func setupGestureRecognizers() {
        // Postavljanje gesture recognizera
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        print("CustomView tapped!")
    }

    override func setupBinding() {
        // Postavljanje bindinga za dugme
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        print("Button tapped!")
    }
}

