//
//  EventView.swift
//  Sofa
//
//  Created by Akademija on 13.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class EventView: BaseView {
    
    private let homeTeamLogo = UIImageView()
    private let awayTeamLogo = UIImageView()
    private let homeTeamLabel = UILabel()
    private let awayTeamLabel = UILabel()
    private let homeScoreLabel = UILabel()
    private let awayScoreLabel = UILabel()
    private let timeLabel = UILabel()
    private let divider = UIImageView()
    private let start = UILabel()
    
    private var event: Event
    
    init(event: Event) {
        self.event = event
        super.init()
    }
    
    override func addViews() {
        addSubview(homeTeamLogo)
        addSubview(awayTeamLogo)
        addSubview(homeTeamLabel)
        addSubview(awayTeamLabel)
        addSubview(homeScoreLabel)
        addSubview(awayScoreLabel)
        addSubview(timeLabel)
        addSubview(divider)
        addSubview(start)
    }
    
    override func styleViews() {
        backgroundColor = .white
        homeTeamLogo.contentMode = .scaleAspectFit
        awayTeamLogo.contentMode = .scaleAspectFit
        
        homeTeamLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        homeTeamLabel.textColor = .black
        
        awayTeamLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        awayTeamLabel.textColor = .black
        
        homeScoreLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        
        awayScoreLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        
        timeLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        timeLabel.textColor = .gray
        timeLabel.textAlignment = .center
        
        start.font = UIFont(name: "Roboto-Regular", size: 12)
        start.textColor = .gray
        start.textAlignment = .center

        
        divider.contentMode = .scaleAspectFit
        divider.image = UIImage(named: "Divider Horizontal")
        
        if let homeLogoUrl = event.homeTeam.logoUrl, let url = URL(string: homeLogoUrl) {
            homeTeamLogo.loadImage(from: url)
        }
        if let awayLogoUrl = event.awayTeam.logoUrl, let url = URL(string: awayLogoUrl) {
            awayTeamLogo.loadImage(from: url)
        }
        
        homeTeamLabel.text = event.homeTeam.name
        awayTeamLabel.text = event.awayTeam.name
        
        
        if let homeScore = event.homeScore {
            homeScoreLabel.text = "\(homeScore)"
        }

        if let awayScore = event.awayScore {
            awayScoreLabel.text = "\(awayScore)"
        }
        
        let (timeText, timeColor,Live) = calculateMatchTime(startTimestamp: event.startTimestamp)
        timeLabel.text = timeText
        timeLabel.textColor = timeColor
        
        if Live {
            homeScoreLabel.textColor = .blue
            awayScoreLabel.textColor = .blue
        } else {
            homeScoreLabel.textColor = .black
            awayScoreLabel.textColor = .black
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"

        let startDate = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        start.text = formatter.string(from: startDate)
        

    }
    
    override func setupConstraints() {
        homeTeamLogo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(80)
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(16)
        }
        homeTeamLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(192)
            make.leading.equalToSuperview().offset(104)
            make.top.equalToSuperview().offset(10)
        }
        
        homeScoreLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(32)
            make.trailing.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
        }
        
        awayTeamLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(192)
            make.leading.equalToSuperview().offset(104)
            make.top.equalToSuperview().offset(30)
        }
        awayTeamLogo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(80)
            make.top.equalToSuperview().offset(30)
            make.width.height.equalTo(16)
        }
        awayScoreLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(32)
            make.trailing.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(30)
        }
        divider.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(63)
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(40)
            make.width.equalTo(1)
        }
        timeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(16)
            make.width.equalTo(56)
            make.centerY.equalToSuperview()
        }
        start.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(56)
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(4)}
            
        self.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
    
    override func setupGestureRecognizers() {
        // Ovdje možete dodati gesture recognizere ako su potrebni
    }

    override func setupBinding() {
        // Ovdje možete postaviti bindings ako koristite neki reactive framework
    }
    private func calculateMatchTime(startTimestamp: Int) -> (String,UIColor,Bool) {
         let currentTimestamp = Int(Date().timeIntervalSince1970)
        
         let elapsedTime = currentTimestamp - startTimestamp

         if elapsedTime < 0 {
             return ("-", .gray,false)
         }
        else if elapsedTime >= 45 * 60 && elapsedTime < 46 * 60 {
            return ("HT", .gray,true)}
        else if elapsedTime >= 90 * 60 {
             return ("FT",.gray,false)
         } else {
             let minutes = elapsedTime / 60
             return ("\(minutes)'" ,.blue,true)
         }
     }
}
    
    
    extension UIImageView {
        func loadImage(from url: URL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }.resume()
        }
    }


