import UIKit
import SnapKit
import SofaAcademic



class LeagueView: BaseView {

    private let logoImageView = UIImageView()
    private let countryLabel = UILabel()
    private let icon = UIImageView()
    private let leagueLabel = UILabel()

    private var laLigaLeague: League
    
    init(laLigaLeague: League ) {
        self.laLigaLeague = laLigaLeague
        super.init()
    }

    override func addViews() {
        addSubview(logoImageView)
        addSubview(countryLabel)
        addSubview(icon)
        addSubview(leagueLabel)
    }

    override func styleViews() {
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        
        backgroundColor = .white
        
        countryLabel.font = UIFont(name: "Roboto-Regular",size: 14)
        countryLabel.textColor = .black
        
        leagueLabel.font = UIFont(name: "Roboto-Regular",size: 14)
        leagueLabel.textColor = .gray
        
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(named: "ic_pointer_right")

        if let logoUrl = laLigaLeague.logoUrl, let url = URL(string: logoUrl) {
            loadImage(from: url)
        }
        if let countryName = laLigaLeague.country?.name {
                  countryLabel.text = countryName
              }
        leagueLabel.text = laLigaLeague.name
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(12)
        }
        countryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(80)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(36)
            make.height.equalTo(16)
        }
        icon.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().offset(116)
            make.top.equalToSuperview().offset(16)
        }
        leagueLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(140)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(91)
            make.height.equalTo(16)
        }
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

    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.logoImageView.image = image
                }
            }
        }.resume()
    }
}
