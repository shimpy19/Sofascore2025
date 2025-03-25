//
//  SportView.swift
//  Sofa
//
//  Created by Akademija on 22.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic


class SportView: BaseView {

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private var sport: Sport?

     init(sport: Sport) {
        self.sport = sport
         super.init()

          iconImageView.image = UIImage(named: sport.iconName)
          titleLabel.text = sport.title
    }

    override func addViews() {
        addSubview(iconImageView)
        addSubview(titleLabel)
    }

    override func styleViews() {
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .background 

        titleLabel.font = .regular14
        titleLabel.textColor = .background
        titleLabel.textAlignment = .center
    }

    override func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.centerX.equalToSuperview()
            make.size.equalTo(16)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}
