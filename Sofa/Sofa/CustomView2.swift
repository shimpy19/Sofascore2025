import UIKit
import SnapKit
import SofaAcademic


class CustomView2: BaseView {
    
    private let divider1 = UIImageView()
    private let divider2 = UIImageView()
    private let divider3 = UIImageView()
    private let divider4 = UIImageView()
    private let event1hteam = UIImageView()
    private let event1ateam = UIImageView()
    
    
    private var events: [Event]
    
    private var laLigaLeague: League
    
    init(laLigaLeague: League,events: [Event]) {
        self.laLigaLeague = laLigaLeague
        self.events = events
        super.init()
    }
    
    override func addViews() {
        addSubview(divider1)
        addSubview(divider2)
        addSubview(divider3)
        addSubview(divider4)
        addSubview(event1hteam)
        addSubview(event1ateam)
    }
    
    override func styleViews() {
        
        backgroundColor = .white
        
        
        divider1.contentMode = .scaleAspectFit
        divider1.image = UIImage(named: "Divider Horizontal")
        
        divider2.contentMode = .scaleAspectFit
        divider2.image = UIImage(named: "Divider Horizontal")
        
        divider3.contentMode = .scaleAspectFit
        divider3.image = UIImage(named: "Divider Horizontal")
        
        divider4.contentMode = .scaleAspectFit
        divider4.image = UIImage(named: "Divider Horizontal")
        
        event1hteam.contentMode = .scaleAspectFit
        event1hteam.clipsToBounds = true
        
        event1ateam.contentMode = .scaleAspectFit
        event1ateam.clipsToBounds = true
        
        if let firstEvent = events.first {
            if let logoUrl = firstEvent.homeTeam.logoUrl, let url = URL(string: logoUrl) {
                event1hteam.loadImage(from: url)
            }
        }
        
        if let firstEvent = events.first {
            if let logoUrl = firstEvent.awayTeam.logoUrl, let url = URL(string: logoUrl) {
                event1ateam.loadImage(from: url)
            }
        }}
    
    
    override func setupConstraints() {
        divider1.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(1)
            make.leading.equalToSuperview().offset(63)
            make.top.equalToSuperview().offset(8)
        }
        divider2.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(1)
            make.leading.equalToSuperview().offset(63)
            make.top.equalToSuperview().offset(64)
        }
        divider3.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(1)
            make.leading.equalToSuperview().offset(63)
            make.top.equalToSuperview().offset(120)
        }
        divider4.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(1)
            make.leading.equalToSuperview().offset(63)
            make.top.equalToSuperview().offset(176)
        }
        event1hteam.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.leading.equalToSuperview().offset(80)
            make.top.equalToSuperview().offset(10)
        }
        event1ateam.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.leading.equalToSuperview().offset(80)
            make.top.equalToSuperview().offset(30)
        }
    }
    
    override func setupGestureRecognizers() {
        // Ovdje možete dodati gesture recognizere ako su potrebni
    }
    
    override func setupBinding() {
        // Ovdje možete postaviti bindings ako koristite neki reactive framework
    }}
    
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


