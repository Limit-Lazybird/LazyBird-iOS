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
    //MARK: - Properties
    var viewModel: ExhibitDetailViewModel?
    
    fileprivate let changeStrFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter
    }()
    
    //MARK: - UI Component
    let exhibitTitleLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 20)
        $0.textColor = .white
    }
    
    lazy var likeBtn = UIButton().then{
        $0.setImage(UIImage(named: "ic_fav_lg_off"), for: .normal)
        $0.setImage(UIImage(named: "ic_fav_lg_on"), for: .selected)
        $0.addTarget(self, action: #selector(likeBtnPressed(_:)), for: .touchUpInside)
    }
    
    let stationTitleLabel = UILabel().then{
        $0.text = "장소"
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = UIColor.Point.or01
    }
    
    let stationLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
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
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = UIColor.Point.or01
    }
    
    let dateLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
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
        $0.font = UIFont.TTFont(type: .MontBold, size: 20)
        $0.textColor = UIColor.Point.pink
    }
    
    let priceLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 20)
        $0.textColor = .white
    }
    
    let wonLabel = UILabel().then{
        $0.text = "원"
        $0.font = UIFont.TTFont(type: .SDMed, size: 17)
        $0.textColor = UIColor.Basic.gray04
    }
    
    let postPriceLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDReg, size: 17)
        $0.textColor = UIColor.Basic.gray04
    }
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.Background.black02
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    @objc func likeBtnPressed(_ sender: UIButton){
        //TODO: 1. 상태별 버튼 이미지 변경
        //TODO: 2. 서버로 request, response
        guard let viewModel = viewModel else {
            print("likeBtnPressed viewModel is nil")
            return
        }
        
        if likeBtn.isSelected{
            LikeAPIManager.shared.requestLikeCancel(exhbt_cd: viewModel.getExhibit().value.exhbt_cd ?? "")
            likeBtn.isSelected = !likeBtn.isSelected
        }else{
            LikeAPIManager.shared.requestLike(exhbt_cd: viewModel.getExhibit().value.exhbt_cd ?? "",
                                              like_yn: "Y")
            likeBtn.isSelected = !likeBtn.isSelected
        }
        
        
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
    
    func config(viewModel: ExhibitDetailViewModel){
        self.viewModel = viewModel
        guard let vm = self.viewModel else { return }
        
        let exhibit = vm.getExhibit().value
        
        self.exhibitTitleLabel.text = exhibit.exhbt_nm?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.stationLabel.text = exhibit.exhbt_lct
        
        self.dateLabel.text = "\(exhibit.exhbt_from_dt ?? "") ~ \(exhibit.exhbt_to_dt ?? "")"
        self.discountLabel.text = exhibit.dc_percent
        
        if let dc_prc = exhibit.dc_prc { // 할인가가 존재할경우
            self.priceLabel.text = dc_prc.replacingOccurrences(of: "원", with: "")
            
            let text = exhibit.exhbt_prc ?? ""
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.strikethroughStyle, value: 1.07, range: (text as NSString).range(of: text))
            self.postPriceLabel.attributedText = attributedString
        }else{ // 할인이 존재하지 않을 경우
            self.priceLabel.text = exhibit.exhbt_prc?.replacingOccurrences(of: "원", with: "")
            priceLabel.snp.remakeConstraints{
                $0.leading.equalToSuperview().offset(16.0)
                $0.bottom.equalToSuperview().offset(-12.0)
            }
        }
        
        if exhibit.like_yn == "Y"{
            likeBtn.isSelected = true
        }else{
            likeBtn.isSelected = false
        }
        
        
        
        
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
            $0.trailing.equalToSuperview().offset(-70.0)
            $0.bottom.equalToSuperview().offset(-101.5)
        }
        
        likeBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10.0)
            $0.trailing.equalToSuperview().offset(-8.0)
            $0.width.equalTo(30.0)
            $0.height.equalTo(30.0)
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
            $0.leading.equalToSuperview().offset(16.0)
            $0.bottom.equalToSuperview().offset(-14.0)
            
        }
        
        priceLabel.snp.makeConstraints{
            $0.leading.equalTo(discountLabel.snp.trailing).offset(8.0)
            $0.bottom.equalToSuperview().offset(-12.0)
        }
        
        wonLabel.snp.makeConstraints{
            $0.centerY.equalTo(priceLabel.snp.centerY)
            $0.leading.equalTo(priceLabel.snp.trailing).offset(3.0)
        }
        
        postPriceLabel.snp.makeConstraints{
            $0.leading.equalTo(wonLabel.snp.trailing).offset(8.0)
            $0.bottom.equalTo(priceLabel.snp.bottom)
        }
    }
}
