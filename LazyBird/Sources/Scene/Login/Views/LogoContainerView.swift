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
        $0.image = UIImage(named: "logo_big")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let titleLabel = UILabel().then{
        $0.text = "Lazybird"
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .MontBold, size: 50)
    }
    
    let subTitleLabel = UILabel().then{
        $0.text = "당신을 위한 전시 큐레이터"
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
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
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        
        welcomLogoImageView.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(160.0)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(139.0)
            $0.height.equalTo(146.0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(welcomLogoImageView.snp.bottom).offset(10.0)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        subTitleLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(10.0)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
