//
//  ExhibitImageContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/10.
//

import UIKit
import SnapKit
import Then


class ExhibitImageContainerView: UIView {
    //MARK: - Properties
    var viewModel: ExhibitDetailViewModel?
    
    
    //MARK: - UI Components
    let exhibitImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    let earlybirdD_dayView = UIView().then{
        $0.backgroundColor = UIColor.Opacity.or0190
    }
    
    let earlybirdLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .MontBold, size: 13)
        $0.textColor = .white
    }
    
    let d_dayLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .MontBold, size: 13)
        $0.textColor = .white
    }
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func config(viewModel: ExhibitDetailViewModel){
        //TODO: 1. 얼리버드,일반전시 각각의 경우,  뷰의 배경색, 라벨의 text 수정해야함 [o]
        //TODO: 2. earlybirdLabel, d_dayLabel 의 text  /  earlybirdD_dayView 의 배경색 [o]
        
        self.viewModel = viewModel
        guard let vm = self.viewModel else { return }
        
        let exhibit = vm.getExhibit().value
        
        self.exhibitImageView.kf.setImage(with: URL(string: exhibit.exhbt_sn ?? "")) // 썸네일 이미지 설정
        self.earlybirdLabel.text = self.getEarlybirdText(eb_yn: exhibit.eb_yn ?? "") // 얼리버드 라벨 설정
        self.d_dayLabel.text = self.getDDayText(exhbt_to_dt: exhibit.exhbt_to_dt ?? "") // D Day 설정
        self.setDDayViewBackground(eb_yn: exhibit.eb_yn ?? "") // 배경색 설정
    }
    
    private func getEarlybirdText(eb_yn: String) -> String{
        //TODO: 얼리버드라면 "Today's earlybird", 일반 전시라면 Current Exhibition [o]
        if eb_yn == "Y"{
            return "Today's earlybird"
        }else{
            return "Current Exhibition"
        }
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
    
    private func setDDayViewBackground(eb_yn: String){
        if eb_yn == "Y"{
            self.earlybirdD_dayView.backgroundColor = UIColor.Opacity.or0190
            self.earlybirdLabel.textColor = .white
            self.d_dayLabel.textColor = .white
        }else if eb_yn == "N"{
            self.earlybirdD_dayView.backgroundColor = UIColor.Opacity.white90
            self.earlybirdLabel.textColor = UIColor.Basic.black01
            self.d_dayLabel.textColor = UIColor.Basic.black01
        }
    }
    
    
    func setUI(){
        self.addSubview(exhibitImageView)
        self.addSubview(earlybirdD_dayView)
        earlybirdD_dayView.addSubview(earlybirdLabel)
        earlybirdD_dayView.addSubview(d_dayLabel)
        
        exhibitImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.height.equalTo(exhibitImageView.snp.width).multipliedBy(1.33333333333)
        }
        
        earlybirdD_dayView.snp.makeConstraints{
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        
        earlybirdLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(11.0)
        }
        
        d_dayLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-11.0)
        }
    }
}
