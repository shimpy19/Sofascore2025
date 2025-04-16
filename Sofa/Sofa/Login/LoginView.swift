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
    func loginViewDidTapLogin(_ loginView: LoginView, username: String,password: String)
}

class LoginView: BaseView {
    
    weak var delegate: LoginViewDelegate?
    
    let loginUsernameTextField = UITextField()
    private let loginPasswordTextField = UITextField()
    let loginButton = UIButton(type: .system)
    private let sofaLogoImageView = UIImageView()
    private let loginContainerView = UIView()
    
    override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func addViews() {
        addSubview(sofaLogoImageView)
        addSubview(loginContainerView)
        loginContainerView.addSubview(loginUsernameTextField)
        loginContainerView.addSubview(loginButton)
        loginContainerView.addSubview(loginPasswordTextField)
    }
    
    override func styleViews() {
        backgroundColor = .sofaBlue

        sofaLogoImageView.image = UIImage(named: "ic_sofascore")
        sofaLogoImageView.contentMode = .scaleAspectFit
        
        loginContainerView.backgroundColor = .background
        loginContainerView.layer.cornerRadius = 16
        loginContainerView.layer.masksToBounds = true

        loginUsernameTextField.placeholder = "Enter username"
        loginUsernameTextField.borderStyle = .roundedRect
        loginUsernameTextField.textAlignment = .center
        loginUsernameTextField.font = .regular14
        
        loginPasswordTextField.placeholder = "Enter password"
        loginPasswordTextField.borderStyle = .roundedRect
        loginPasswordTextField.textAlignment = .center
        loginPasswordTextField.font = .regular14
        loginPasswordTextField.isSecureTextEntry = true

        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.background, for: .normal)
        loginButton.backgroundColor = .sofaBlue
        loginButton.layer.cornerRadius = 8
        loginButton.titleLabel?.font = .bold14
        
        loginUsernameTextField.autocapitalizationType = .none
        loginPasswordTextField.autocapitalizationType = .none

        
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    override func setupConstraints() {
        sofaLogoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(200)
            $0.size.equalTo(150)
        }
        
        loginContainerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(200)
        }
        
        loginUsernameTextField.snp.makeConstraints {
            $0.top.equalTo(loginContainerView.snp.top).inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        loginPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(loginUsernameTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(loginPasswordTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(loginContainerView.snp.bottom).inset(32)
            
            
        }
    }
    
    @objc private func loginTapped() {
        let username = loginUsernameTextField.text ?? ""
        let password = loginPasswordTextField.text ?? ""
        delegate?.loginViewDidTapLogin(self, username: username, password: password)
    }
}
