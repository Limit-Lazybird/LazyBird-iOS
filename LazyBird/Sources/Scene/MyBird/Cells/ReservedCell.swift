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
    //MARK: - Properties
    static let identifier = "reservedCell"
    var currentExhibit: Exhibit?
    var delegate: ReservedExhibitViewControllerDelegate?
    
    //MARK: - UI Components
    let dDayBtn = UIButton().then{
        $0.titleLabel?.font = UIFont.TTFont(type: .MontBold, size: 11)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = UIColor.Point.or01
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 22 / 2
        $0.titleEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
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
        self.backgroundColor = UIColor.Background.darkGray02
        
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self,
                                                               action: #selector(longPressGesture(_:))))
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    //MARK: - Functions
    @objc func longPressGesture(_ sender: Any){
        //TODO: 전시회 삭제 alert 띄울까? delegate 로 하자
        guard let delegate = delegate else {
            print("ReservedCell longPressGesture delegate is nil")
            return
        }
        
        guard let currentExhibit = currentExhibit else {
            print("ReservedCell longPressGesture currentExhibit is nil")
            return
        }


        delegate.checkReseredExhibitionDeleteAlert(exhbt_cd: currentExhibit.exhbt_cd ?? "")
    }
    
    private func getDDayText(exhbt_to_dt: String) -> String{
        //TODO: 전시종료일짜 - 현재날짜 계산해서 return [o]
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date: Date = dateFormatter.date(from: exhbt_to_dt){
            return "D - \(Int(date.timeIntervalSince(Date()))/86400 + 1)"
        }
        
        return ""
    }
    
    func config(exhibit: Exhibit){
        self.currentExhibit = exhibit
        
        dDayBtn.setTitle(getDDayText(exhbt_to_dt: exhibit.exhbt_to_dt ?? ""),
                         for: .normal)
        dDayBtn.titleEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        exhibitTitleLabel.text = exhibit.exhbt_nm
        locationLabel.text = exhibit.exhbt_lct
        dateLabel.text = "\(exhibit.exhbt_from_dt ?? "") ~ \(exhibit.exhbt_to_dt ?? "")"
        priceLabel.text = exhibit.exhbt_prc
        exhibitImageView.kf.setImage(with: URL(string: exhibit.exhbt_sn ?? ""))
    }
    
    func setUI(){
        self.addSubview(dDayBtn)
        self.addSubview(exhibitTitleLabel)
        self.addSubview(locationLabel)
        self.addSubview(dateLabel)
        self.addSubview(postPriceLabel)
        self.addSubview(discountLabel)
        self.addSubview(priceLabel)
        self.addSubview(exhibitImageView)
        
        dDayBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(14.0)
            $0.leading.equalToSuperview().offset(15.0)
            $0.width.equalTo(60.0)
            $0.height.equalTo(22.0)
        }
        
        exhibitTitleLabel.snp.makeConstraints{
            $0.top.equalTo(dDayBtn.snp.bottom).offset(14.0)
            $0.leading.equalTo(dDayBtn.snp.leading)
            $0.trailing.equalTo(exhibitImageView.snp.leading).offset(-16.0)
        }
        
        locationLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitTitleLabel.snp.bottom).offset(5.0)
            $0.leading.equalTo(dDayBtn.snp.leading)
        }
        
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(5.0)
            $0.leading.equalTo(dDayBtn.snp.leading)
        }
        
        postPriceLabel.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).offset(10.0)
            $0.leading.equalTo(dDayBtn.snp.leading)
        }
        
        discountLabel.snp.makeConstraints{
            $0.top.equalTo(postPriceLabel.snp.bottom).offset(1.0)
            $0.leading.equalTo(dDayBtn.snp.leading)
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
