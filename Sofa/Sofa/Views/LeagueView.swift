import UIKit
import SnapKit
import SofaAcademic

class LeagueView: BaseView {

    private let logoImageView = UIImageView()
    private let countryLabel = UILabel()
    private let iconImageView = UIImageView()
    private let leagueLabel = UILabel()

    private let laLigaLeague: League
    
    init(laLigaLeague: League ) {
        self.laLigaLeague = laLigaLeague
        super.init()
    }

    override func addViews() {
        addSubview(logoImageView)
        addSubview(countryLabel)
        addSubview(iconImageView)
        addSubview(leagueLabel)
    }

    override func styleViews() {
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        
        backgroundColor = .white
        
        countryLabel.font = .regular14
        countryLabel.textColor = .primaryText
        
        leagueLabel.font = .regular14
        leagueLabel.textColor = .secondaryText
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: "ic_pointer_right")

        if let logoUrl = laLigaLeague.logoUrl, let url = URL(string: logoUrl) {
            logoImageView.loadImage(from: url)
        }
        if let countryName = laLigaLeague.country?.name {
                  countryLabel.text = countryName
              }
        leagueLabel.text = laLigaLeague.name
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.top.equalToSuperview().inset(12)
        }
        countryLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(32)
            $0.top.bottom.equalToSuperview().inset(20)
        }
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.leading.equalTo(countryLabel.snp.trailing)
            $0.top.bottom.equalToSuperview().inset(16)
        }
        leagueLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing)
            $0.top.bottom.equalToSuperview().inset(20)
        }
    }

}
