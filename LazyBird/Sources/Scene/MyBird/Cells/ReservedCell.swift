//
//  ReservedCell.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit
import SnapKit
import Then

class ReservedCell: UICollectionViewCell {
    static let identifier = "reservedCell"
    
    //MARK: - UI Components
    let dDayLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .MontBold, size: 11)
        $0.textColor = .white
        $0.backgroundColor = UIColor.Point.or01
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 21 / 2
    }
    
    let exhibitTitleLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    let locationLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDMed, size: 11)
        $0.textColor = .white
    }
    
    let dateLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDMed, size: 11)
        $0.textColor = .white
    }
    
    let postPriceLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDReg, size: 11)
        $0.textColor = UIColor.Basic.gray04
    }
    
    let discountLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .MontSemiBold, size: 12)
        $0.textColor = UIColor.Point.pink
    }
    
    let priceLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .MontBold, size: 13)
        $0.textColor = .white
    }
    
    let exhibitImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    //MARK: - Life Cycle
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20.0
        self.backgroundColor = .brown
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    //MARK: - Functions
    func config(exhibit: Exhibit){
        
    }
    
    func setUI(){
        self.addSubview(dDayLabel)
        self.addSubview(exhibitTitleLabel)
        self.addSubview(locationLabel)
        self.addSubview(dateLabel)
        self.addSubview(postPriceLabel)
        self.addSubview(discountLabel)
        self.addSubview(priceLabel)
        self.addSubview(exhibitImageView)
        
        dDayLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(14.0)
            $0.leading.equalToSuperview().offset(15.0)
        }
        
        exhibitTitleLabel.snp.makeConstraints{
            $0.top.equalTo(dDayLabel.snp.bottom).offset(14.0)
            $0.leading.equalTo(dDayLabel.snp.leading)
            $0.trailing.equalTo(exhibitImageView.snp.trailing).offset(-16.0)
        }
        
        locationLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitTitleLabel.snp.bottom).offset(5.0)
            $0.leading.equalTo(dDayLabel.snp.leading)
        }
        
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(5.0)
            $0.leading.equalTo(dDayLabel.snp.leading)
        }
        
        postPriceLabel.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).offset(10.0)
            $0.leading.equalTo(dDayLabel.snp.leading)
        }
        
        discountLabel.snp.makeConstraints{
            $0.top.equalTo(postPriceLabel.snp.bottom).offset(1.0)
            $0.leading.equalTo(dDayLabel.snp.leading)
        }
        
        priceLabel.snp.makeConstraints{
            $0.top.equalTo(discountLabel.snp.top)
            $0.leading.equalTo(discountLabel.snp.trailing).offset(4.0)
        }
        
        exhibitImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-16.0)
            $0.width.equalTo(exhibitImageView.snp.height).multipliedBy(0.75)
        }
    }
}
