//
//  MyBirdExhibitPreview.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit

class MyBirdExhibitPreview: UIView {
    //MARK: - UI Components
    let exhibitImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    let exhibitTitleLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 11)
        $0.numberOfLines = 0
        $0.textColor = .white
    }
    
    let dateLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDReg, size: 11)
        $0.textColor = .white
    }
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Functions
    func config(){
        //TODO: 바인딩하자
        self.exhibitImageView.image = UIImage(named: "test")
        self.exhibitTitleLabel.text = "내맘쏙 모두의 그림책"
        self.dateLabel.text = "2021.12.24 ~ 2022.03.27"
    }
    
    func setUI(){
        self.addSubview(exhibitImageView)
        self.addSubview(exhibitTitleLabel)
        self.addSubview(dateLabel)
        
        exhibitImageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(exhibitImageView.snp.width).multipliedBy(1.33076923077)
            
        }
        
        exhibitTitleLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitImageView.snp.bottom).offset(13.0)
            $0.leading.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitTitleLabel.snp.bottom).offset(4.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-4.0)
        }
    }
}
