//
//  ExhibitCell.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/15.
//

import UIKit
import SnapKit
import Then
import Kingfisher

/*
 1. 백그라운드 이미지
 2. 좋아요 버튼
 3. 전시회 타이틀
 4. 전시 장소
 5. 날짜
 6. 가격 원
 */


class ExhibitCell: UICollectionViewCell {
    //MARK: - Properties
    
    static let identifier = "exhibitCell"
    fileprivate let changeStrFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter
    }()
    
    //MARK: - UI Components
    let thumbnailImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var likeBtn = UIButton().then{
        $0.setImage(UIImage(named: "ic_fav_sm_off"), for: .normal)
        $0.setImage(UIImage(named: "ic_fav_sm_on"), for: .selected)
        $0.addTarget(self, action: #selector(likeBtnPressed(_:)), for: .touchUpInside)
    }
    
    let bgView = UIView().then{
        $0.backgroundColor = UIColor.Opacity.black70
    }
    
    let exhibitTitleLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.textColor = .white
    }
    
    let stationLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDMed, size: 11)
        $0.textColor = .white
    }
    
    let dateTitleLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDMed, size: 11)
        $0.textColor = .white
    }
    
    let priceLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.textColor = .white
    }
    
    let wonLabel = UILabel().then{
        $0.text = "원"
        $0.font = UIFont.TTFont(type: .SDMed, size: 9)
        $0.textColor = UIColor.Basic.gray05
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
    
    @objc func likeBtnPressed(_ sender: UIButton){
        likeBtn.isSelected = !likeBtn.isSelected
    }
    
    func config(exhibit: Exhibit){
        thumbnailImageView.kf.setImage(with: URL(string: exhibit.exhbt_sn ?? ""))
        exhibitTitleLabel.text = exhibit.exhbt_nm
        stationLabel.text = exhibit.exhbt_lct
        dateTitleLabel.text = "\(self.getExhibitDate(date: exhibit.exhbt_from_dt ?? "")) ~ \(self.getExhibitDate(date: exhibit.exhbt_to_dt ?? ""))"
        priceLabel.text = exhibit.exhbt_prc?.replacingOccurrences(of: "원", with: "")
   
    }
    
    private func getExhibitDate(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date: Date = dateFormatter.date(from: date){
            return changeStrFormatter.string(from: date)
        }
        
        return ""
    }
    
    func setUI(){
        self.addSubview(thumbnailImageView)
        self.addSubview(likeBtn)
        self.addSubview(bgView)
        bgView.addSubview(exhibitTitleLabel)
        bgView.addSubview(stationLabel)
        bgView.addSubview(dateTitleLabel)
        bgView.addSubview(priceLabel)
        bgView.addSubview(wonLabel)
        
        thumbnailImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        bgView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(self.snp.height).multipliedBy(0.34836065573)
        }
        
        likeBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-10.0)
            $0.bottom.equalTo(bgView.snp.top).offset(-15.0)
        }
        
        exhibitTitleLabel.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(8.0)
            $0.trailing.equalToSuperview().offset(-8.0)
        }
        
        stationLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitTitleLabel.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview().offset(8.0)
            $0.trailing.equalToSuperview().offset(-8.0)
        }
        
        dateTitleLabel.snp.makeConstraints{
            $0.top.equalTo(stationLabel.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview().offset(8.0)
            $0.trailing.equalToSuperview().offset(-8.0)
        }
        
        priceLabel.snp.makeConstraints{
//            $0.top.equalTo(dateTitleLabel.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview().offset(8.0)
            $0.bottom.equalToSuperview().offset(-7.0)
        }
        
        wonLabel.snp.makeConstraints{
            $0.leading.equalTo(priceLabel.snp.trailing).offset(2.0)
            $0.bottom.equalTo(priceLabel.snp.bottom).offset(-2.0)
        }
    }
}
