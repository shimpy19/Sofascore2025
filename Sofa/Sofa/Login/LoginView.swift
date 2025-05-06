//
//  LoginView.swift
//  Sofa
//
//  Created by Akademija on 14.04.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

protocol LoginViewDelegate: AnyObject {
    func loginTapHandler(username: String,password: String)
}

class LoginView: BaseView {
    
    weak var delegate: LoginViewDelegate?
    
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let sofaLogoImageView = UIImageView()
    private let containerView = UIView()
    private let spinner = UIActivityIndicatorView(style: .medium)
    private let errorLabel = UILabel()

    
    override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func addViews() {
        addSubview(sofaLogoImageView)
        addSubview(containerView)
        containerView.addSubview(usernameTextField)
        containerView.addSubview(loginButton)
        containerView.addSubview(passwordTextField)
        loginButton.addSubview(spinner)
        addSubview(errorLabel)
    }
    
    override func styleViews() {
        backgroundColor = .sofaBlue
        
        spinner.color = .background

        sofaLogoImageView.image = UIImage(named: "ic_sofascore")
        sofaLogoImageView.contentMode = .scaleAspectFit
        
        containerView.backgroundColor = .background
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true
        
        usernameTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter username",
            attributes: [.foregroundColor: UIColor.secondaryText]
        )
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.layer.borderColor = UIColor(named: "secondaryText")?.cgColor
        usernameTextField.textAlignment = .center
        usernameTextField.font = .regular14
        usernameTextField.backgroundColor = .background
        usernameTextField.textColor = .primaryText
        
        
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter password",
            attributes: [.foregroundColor: UIColor.secondaryText]
        )
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderColor = UIColor(named: "secondaryText")?.cgColor
        passwordTextField.textAlignment = .center
        passwordTextField.font = .regular14
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .background
        passwordTextField.textColor = .primaryText

        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.background, for: .normal)
        loginButton.backgroundColor = .sofaBlue
        loginButton.layer.cornerRadius = 8
        loginButton.titleLabel?.font = .bold14
        
        usernameTextField.autocapitalizationType = .none
        passwordTextField.autocapitalizationType = .none
        
        errorLabel.textColor = .background
        errorLabel.font = .regular14
        errorLabel.textAlignment = .center
        
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    override func setupConstraints() {
        sofaLogoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(200)
            $0.size.equalTo(150)
        }
        
        containerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.top.equalTo(sofaLogoImageView.snp.bottom)
            $0.bottom.equalTo(errorLabel.snp.top).offset(-16)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)

        }
        spinner.snp.makeConstraints {
            $0.center.equalTo(loginButton)
        }
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(sofaLogoImageView.snp.bottom).offset(190)
            $0.centerX.equalToSuperview()
        }

    }
    
    @objc private func loginTapped() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        spinner.startAnimating()
        loginButton.setTitle("", for: .normal)
        delegate?.loginTapHandler(username: username, password: password)
    }
    func stopLoading(message: String) {
        spinner.stopAnimating()
        loginButton.setTitle("Login", for: .normal)
        errorLabel.text = message
    }

}
