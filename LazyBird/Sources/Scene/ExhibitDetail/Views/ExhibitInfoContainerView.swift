//
//  ExhibitInfoContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/10.
//

import UIKit
import Then
import SnapKit


/*
 1. 전시회 타이틀 라벨
 2. 좋아요 버튼
 3. 장소 라벨
 4. 날짜 라벨
 5. discount 라벨
 6. price 라벨
 7. won 라벨
 8. post price 라벨
 */

class ExhibitInfoContainerView: UIView {
    
    let exhibitTitleLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textColor = .white
    }
    
    lazy var likeBtn = UIButton().then{
        $0.setImage(UIImage(named: "like"), for: .normal)
        $0.setImage(UIImage(named: "ic_fav_big"), for: .selected)
    }
    
    let stationTitleLabel = UILabel().then{
        $0.text = "장소"
        $0.font = UIFont.boldSystemFont(ofSize: 11)
        $0.textColor = UIColor.Point.or01
    }
    
    let stationLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 11)
        $0.textColor = .white
    }
    
    lazy var stationStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 7.0
        $0.addArrangedSubview(stationTitleLabel)
        $0.addArrangedSubview(stationLabel)
    }
    
    let dateTitleLabel = UILabel().then{
        $0.text = "날짜"
        $0.font = UIFont.boldSystemFont(ofSize: 11)
        $0.textColor = UIColor.Point.or01
    }
    
    let dateLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 11)
        $0.textColor = .white
    }
    
    lazy var dateStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 7.0
        $0.addArrangedSubview(dateTitleLabel)
        $0.addArrangedSubview(dateLabel)
    }
    
    let discountLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textColor = UIColor.Point.pink
    }
    
    let priceLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .white
    }
    
    let wonLabel = UILabel().then{
        $0.text = "원"
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = UIColor.Basic.gray04
    }
    
    let postPriceLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = UIColor.Basic.gray04
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.Background.black02
        
        setUI()
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func likeBtnPressed(_ sender: UIButton){
        //TODO: 1. 상태별 버튼 이미지 변경
        //TODO: 2. 서버로 request, response
        likeBtn.isSelected = !likeBtn.isSelected
        print("라이크 버튼 눌림 --> \(likeBtn.isSelected)")
    }
    
    func config(){
        exhibitTitleLabel.text = "미구엘 슈발리에 제주 특별전"
        stationLabel.text = "아쿠아플라넷 제주"
        dateLabel.text = "2021.11.08 ~ 2021.12.31"
        discountLabel.text = "50%"
        priceLabel.text = "10,000"
        
        let text = "20,000 원"
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.strikethroughStyle, value: 1.07, range: (text as NSString).range(of:"20,000"))
        postPriceLabel.attributedText = attributedString
    }
    
    func setUI(){
        self.addSubview(exhibitTitleLabel)
        self.addSubview(likeBtn)
        self.addSubview(stationStackView)
        self.addSubview(dateStackView)
        self.addSubview(discountLabel)
        self.addSubview(priceLabel)
        self.addSubview(wonLabel)
        self.addSubview(postPriceLabel)
        
        exhibitTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(13.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.bottom.equalToSuperview().offset(-101.5)
        }
        
        likeBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.width.equalTo(22.0)
            $0.height.equalTo(20.0)
            $0.bottom.equalToSuperview().offset(-103.5)
        }
        
        stationStackView.snp.makeConstraints{
            $0.top.equalTo(exhibitTitleLabel.snp.bottom).offset(12.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        dateStackView.snp.makeConstraints{
            $0.top.equalTo(stationStackView.snp.bottom).offset(6.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        discountLabel.snp.makeConstraints{
            $0.top.equalTo(dateStackView.snp.bottom).offset(23.5)
            $0.leading.equalToSuperview().offset(16.0)
            $0.bottom.equalToSuperview().offset(-12.0)
        }
        
        priceLabel.snp.makeConstraints{
            $0.top.equalTo(dateStackView.snp.bottom).offset(24.0)
            $0.leading.equalTo(discountLabel.snp.trailing).offset(8.0)
            $0.bottom.equalToSuperview().offset(-12.0)
        }
        
        wonLabel.snp.makeConstraints{
            $0.leading.equalTo(priceLabel.snp.trailing).offset(3.0)
            $0.bottom.equalToSuperview().offset(-12.0)
        }
        
        postPriceLabel.snp.makeConstraints{
            $0.leading.equalTo(wonLabel.snp.trailing).offset(8.0)
            $0.bottom.equalToSuperview().offset(-12.0)
        }
    }
}
