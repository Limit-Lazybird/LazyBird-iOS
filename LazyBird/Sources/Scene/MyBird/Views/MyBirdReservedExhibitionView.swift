//
//  MyBirdReservedExhibitionView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit
import SnapKit
import Then

class MyBirdReservedExhibitionView: UIView {
    //MARK: - Properties
    var delegate: MyBirdViewControllerProtocol?
    
    //MARK: - UI Components
    let ticketingTitleLabel = UILabel().then{
        $0.text = "예매한 전시"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = .white
    }
    
    let noResultLabel = UILabel().then{
        $0.text = "예매한 전시가 없어요."
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.Basic.gray03
    }
    
    lazy var moreBtn = UIButton().then{
        $0.setImage(UIImage(named: "ic_expand_light"), for: .normal)
        $0.addTarget(self, action: #selector(moreBtnPressed(_:)), for: .touchUpInside)
    }
    
    let leftExhibitPreview = MyBirdExhibitPreview()
    let leftDDayBtn = UIButton().then{
        $0.backgroundColor = UIColor.Point.or01
        $0.titleLabel?.font = UIFont.TTFont(type: .MontBold, size: 11)
//        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 22 / 2
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowRadius = 2.0
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    let rightDDayBtn = UIButton().then{
        $0.backgroundColor = UIColor.Point.or01
        $0.titleLabel?.font = UIFont.TTFont(type: .MontBold, size: 11)
//        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 22 / 2
        $0.layer.cornerRadius = 22 / 2
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowRadius = 3.0
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    let rightExhibitPreview = MyBirdExhibitPreview()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.Background.darkGray02
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(moveToDetail(_:))))
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Functions
    @objc func moveToDetail(_ sender: Any){
        self.delegate?.moveToReservedExhibitDetail()
    }
    
    @objc func moreBtnPressed(_ sender: UIButton){
        self.delegate?.moveToReservedExhibitDetail()
    }
    
    func config(exhibit: [Exhibit]){
        switch exhibit.count{
        case 0:
            print("값이 하나도 없습니당")
            self.noResultLabel.isHidden = false
            self.leftDDayBtn.isHidden = true
            self.rightDDayBtn.isHidden = true
            self.leftExhibitPreview.config(exhibit: nil)
            self.rightExhibitPreview.config(exhibit: nil)
            break
        case 1:
            self.noResultLabel.isHidden = true
            self.leftDDayBtn.isHidden = false
            self.rightDDayBtn.isHidden = true
            self.leftExhibitPreview.config(exhibit: exhibit[0])
            self.rightExhibitPreview.config(exhibit: nil)
            self.leftDDayBtn.setTitle(getDDayText(exhbt_to_dt: exhibit[0].exhbt_to_dt ?? ""), for: .normal)
            break
        case 2:
            self.noResultLabel.isHidden = true
            self.leftDDayBtn.isHidden = false
            self.rightDDayBtn.isHidden = false
            self.leftExhibitPreview.config(exhibit: exhibit[0])
            self.rightExhibitPreview.config(exhibit: exhibit[1])
            self.leftDDayBtn.setTitle(getDDayText(exhbt_to_dt: exhibit[0].exhbt_to_dt ?? ""), for: .normal)
            self.rightDDayBtn.setTitle(getDDayText(exhbt_to_dt: exhibit[1].exhbt_to_dt ?? ""), for: .normal)
            break
        default:
            self.leftDDayBtn.isHidden = false
            self.rightDDayBtn.isHidden = false
            self.noResultLabel.isHidden = false
            self.leftExhibitPreview.config(exhibit: exhibit[0])
            self.rightExhibitPreview.config(exhibit: exhibit[1])
            self.leftDDayBtn.setTitle(getDDayText(exhbt_to_dt: exhibit[0].exhbt_to_dt ?? ""), for: .normal)
            self.rightDDayBtn.setTitle(getDDayText(exhbt_to_dt: exhibit[1].exhbt_to_dt ?? ""), for: .normal)
            print("두개 이상이니까 그냥 다")
        }
    }
    
    func setUI(){
        self.addSubview(ticketingTitleLabel)
        self.addSubview(moreBtn)
        self.addSubview(leftExhibitPreview)
        self.addSubview(rightExhibitPreview)
        self.addSubview(leftDDayBtn)
        self.addSubview(rightDDayBtn)
        self.addSubview(noResultLabel)
        
        ticketingTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        moreBtn.snp.makeConstraints{
            $0.centerY.equalTo(ticketingTitleLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.width.height.equalTo(24.0)
        }

        leftExhibitPreview.snp.makeConstraints{
            $0.top.equalTo(ticketingTitleLabel.snp.bottom).offset(27.0)
            $0.leading.equalToSuperview().offset(28.0)
            $0.bottom.equalToSuperview().offset(-28.0)
        }
        
        leftDDayBtn.snp.makeConstraints{
            $0.top.equalTo(leftExhibitPreview.snp.top).offset(-10.0)
            $0.leading.equalTo(leftExhibitPreview.snp.leading).offset(-12.0)
            $0.width.equalTo(48.0)
            $0.height.equalTo(22.0)
        }
        
        rightExhibitPreview.snp.makeConstraints{
            $0.top.equalTo(leftExhibitPreview.snp.top)
            $0.leading.equalTo(leftExhibitPreview.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().offset(-28.0)
            $0.width.equalTo(leftExhibitPreview.snp.width)
        }
        
        rightDDayBtn.snp.makeConstraints{
            $0.top.equalTo(rightExhibitPreview.snp.top).offset(-10.0)
            $0.leading.equalTo(rightExhibitPreview.snp.leading).offset(-12.0)
            $0.width.equalTo(48.0)
            $0.height.equalTo(22.0)
        }
        
        noResultLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
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
}
