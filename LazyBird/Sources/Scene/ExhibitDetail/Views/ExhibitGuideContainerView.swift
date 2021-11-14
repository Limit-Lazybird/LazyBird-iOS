//
//  ExhibitGuideContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/10.
//

import UIKit
import SnapKit
import Then

/*
 ∙•・
 1. 알림 라벨
 2. 티켓 판매기간 알림 라벨
 3. 주의할점 라벨 -> 이부분은 몇개인지 모르니까 음,, 코드적으로 라벨을 만들고, 그 내용을 채우는 식으로 해야할듯. 레이아웃은 일단 스택뷰 만들어놓고 거기에 넣는 식으로 하면 되지 않을까앂음
 */

class ExhibitGuideContainerView: UIView {
    let dummyAlertMessages: [String] = ["매주 월요일은 휴관합니다.",
                                        "36개월 미만은 보호자 동반 유무에 관계없이 입장이 불가합니다.",
                                        "13세 미만 어린이는 보호자 동반이 반드시 필요합니다.",
                                        "주차장은 제공되지 않으며 대중교통을 추천드립니다."]
    
    
    let warningLabel = UILabel().then{
        $0.text = "전시회 예매 전 확인하세요."
        $0.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.textColor = UIColor.Point.or01
    }
    
    let alertLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = .white
    }
    
    lazy var messageStackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 4.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.Background.black02
        
        config()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(){
        alertLabel.text = "얼리버드 티켓은 12월 17일까지 판매됩니다."
        
        for message in dummyAlertMessages{
            let messageLabel = UILabel().then{
                $0.text = "• \(message)"
                $0.font = UIFont.TTFont(type: .SDReg, size: 13)
                $0.textColor = .white
            }
            messageStackView.addArrangedSubview(messageLabel)
        }
        
    }
    
    func setUI(){
        self.addSubview(warningLabel)
        self.addSubview(alertLabel)
        self.addSubview(messageStackView)
        
        warningLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(14.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        alertLabel.snp.makeConstraints{
            $0.top.equalTo(warningLabel.snp.bottom).offset(13.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        messageStackView.snp.makeConstraints{
            $0.top.equalTo(alertLabel.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.bottom.equalToSuperview().offset(-20.0)
        }
    }

}
