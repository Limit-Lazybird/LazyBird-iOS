//
//  UnregisteredExhibitionAlertView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/02.
//

import UIKit
import SnapKit
import Then

class UnregisteredExhibitionAlertView: UIView {
    //TODO: 라벨하나, 버튼하나 넣을 예정
    //MARK: - UI Components
    let contentView = UIView().then{
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.layer.cornerRadius = 10
    }
    let alertLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = .white
    }
    
    lazy var moreBtn = UIButton().then{
        $0.setImage(UIImage(named: "ic_expand_light"), for: .normal)
        $0.addTarget(self, action: #selector(moreBtnPressend(_:)), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.Background.darkGray02
        self.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(moveToAddSchedule(_:))))
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Functions
    @objc func moveToAddSchedule(_ sender: Any){
        //TODO: 전시 일정 추가화면으로 이동
        print("//TODO: 전시 일정 추가화면으로 이동")
    }
    
    @objc func moreBtnPressend(_ sender: UIButton){
        //TODO: 전시 일정 추가화면으로 이동
        print("//TODO: 전시 일정 추가화면으로 이동")
    }
    
    func config(alertCnt: String){
        self.alertLabel.attributedText = getAttributeString(alertCnt: alertCnt)
    }
    
    func getAttributeString(alertCnt: String) -> NSMutableAttributedString{
        let fullText = "추가되지 않은 전시 일정이 \(alertCnt) 개 있습니다"
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "\(alertCnt)")
        
        attribtuedString.addAttribute(.foregroundColor, value: UIColor.Point.or01, range: range)
        attribtuedString.addAttribute(.font, value: UIFont.TTFont(type: .MontBold, size: 13), range: range)
        return attribtuedString
    }
    
    func setUI(){
        self.addSubview(contentView)
        contentView.addSubview(alertLabel)
        contentView.addSubview(moreBtn)
        
        contentView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.height.equalTo(40.0)
        }
        
        alertLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        moreBtn.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10.0)
            $0.width.height.equalTo(20.0)
        }
    }
}
