//
//  LogoContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/26.
//

import UIKit
import SnapKit
import Then

class LogoContainerView: UIView {
    let welcomLogoImageView = UIImageView().then{
        $0.image = UIImage(named: "welcomeLogo")
        $0.contentMode = .scaleAspectFill
    }
    
    let logoImageView = UIImageView().then{
        $0.image = UIImage(named: "loginLogo")
        $0.contentMode = .scaleAspectFill
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.Opacity.black30
    
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        self.addSubview(welcomLogoImageView)
        self.addSubview(logoImageView)
        
        welcomLogoImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(135.0)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(62.0)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(62.0)
            $0.height.equalTo(63.0)
        }
        
        logoImageView.snp.makeConstraints{
            $0.top.equalTo(welcomLogoImageView.snp.bottom).offset(63.0)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(112.0)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(87.0)
            $0.height.equalTo(168.0)
        }
    }
}
