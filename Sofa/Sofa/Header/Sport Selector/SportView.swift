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
    var sport: Sport

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
        
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail

        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .background 

        titleLabel.font = .regular14
        titleLabel.textColor = .background
        titleLabel.textAlignment = .center
    }

    override func setupConstraints() {
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(16)
            $0.bottom.equalTo(titleLabel.snp.top).inset(-4)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).inset(4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-4)
        }
    }
}
