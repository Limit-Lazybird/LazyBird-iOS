//
//  EarlyBirdCell.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/27.
//

import UIKit
import SnapKit
import Then

class EarlyBirdCell: UICollectionViewCell {
    static let identifier: String = "earlyBirdCell"
    static let height: CGFloat = 436.0
    
    let exhibitImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    let blurView = UIView().then{
        $0.backgroundColor = UIColor.Background.bgBlack2
    }
    
    lazy var titleLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .white
    }
    lazy var likeBtn = UIButton().then{
        $0.setImage(UIImage(named: "like"), for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(likeBtnPressed(_:)), for: .touchUpInside)
    }
    
    let leftStackView = UIStackView().then{
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 6
    }
    
    lazy var locationLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = .white
    }
    lazy var dateLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = .white
    }
    let rightStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 4
    }
    
    lazy var discountLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textColor = UIColor.Point.pink
    }
    lazy var priceLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .white
    }
    lazy var wonLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = UIColor.Basic.gray06
        $0.text = "원"
    }
    
    @objc func likeBtnPressed(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected{ // 눌렸을경우 빨간하트
            // TODO: 빨간하트로 전환
            print("test --> 빨간 하트로 전환 됨")
        }else{
            // TODO: 빈 하트로 전환
            print("test --> 빈 하트로 전환 됨")
        }
    }
    
    override init(frame : CGRect) {
        super.init(frame: frame)
//        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        self.backgroundColor = .white
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func config(imageUrl: String){
        exhibitImageView.image = UIImage(named: imageUrl)
        titleLabel.text = "살바도르 달리전"
        locationLabel.text = "성신여대입구"
        dateLabel.text = "2021.10.01 ~ 2021.10.11"
        discountLabel.text = "50%"
        priceLabel.text = "10,000"
    }
    
    
    func setUI(){
        self.contentView.addSubview(exhibitImageView)
        self.contentView.addSubview(blurView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(likeBtn)
        self.contentView.addSubview(leftStackView)
        self.contentView.addSubview(rightStackView)
        self.leftStackView.addArrangedSubview(locationLabel)
        self.leftStackView.addArrangedSubview(dateLabel)
        self.rightStackView.addArrangedSubview(discountLabel)
        self.rightStackView.addArrangedSubview(priceLabel)
        self.rightStackView.addArrangedSubview(wonLabel)
        
        exhibitImageView.snp.makeConstraints{
            $0.edges.equalTo(self.contentView.safeAreaLayoutGuide)
        }
        
        blurView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalTo(self.contentView.safeAreaLayoutGuide)
            $0.height.equalTo(116.0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(self.contentView.safeAreaLayoutGuide).offset(12.0)
            $0.top.equalTo(blurView.snp.top).offset(11.0)
            $0.trailing.equalTo(likeBtn.snp.leading).inset(15.0)
            $0.height.equalTo(24.0)
        }
        
        likeBtn.snp.makeConstraints{
            $0.top.equalTo(blurView.snp.top).offset(12.0)
            $0.trailing.equalTo(self.contentView.safeAreaLayoutGuide).inset(11.0)
            $0.width.equalTo(22.0)
            $0.height.equalTo(20.0)
        }
        
        leftStackView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(24.0)
            $0.leading.equalTo(self.contentView.safeAreaLayoutGuide).offset(12.0)
            $0.bottom.equalTo(self.contentView.safeAreaLayoutGuide).inset(15.0)
        }
        
        rightStackView.snp.makeConstraints{
            $0.bottom.equalTo(self.contentView.safeAreaLayoutGuide).inset(12.0)
            $0.trailing.equalTo(self.contentView.safeAreaInsets).inset(16.0)
        }
    }
}
