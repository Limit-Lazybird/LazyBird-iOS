//
//  ExhibitNoticeViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/24.
//

import UIKit
import SnapKit
import Then

class ExhibitNoticeViewController: UIViewController {
    //MARK: - UI Components
    let infoImageView = UIImageView().then{
        $0.image = UIImage(named: "ic_info")
        $0.contentMode = .scaleAspectFill
    }
    
    let stickView = UIView().then{
        $0.backgroundColor = UIColor.Opacity.or0190
    }
    
    let alertTitleLabel = UILabel().then{
        $0.text = "예매 전 주의사항"
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
    }
    
    let noticeView = NoticeView().then{
        $0.config(notice: "당사는 티켓 할인 수수료를 별도로 요구하지 않습니다.")
    }
    
    let noticeViewTwo = NoticeView().then{
        $0.config(notice: "전시 관람에 대한 유의사항은 해당 판매처 & 전시장 기준에 따라주세요.")
    }
    
    let noticeViewThree = NoticeView().then{
        $0.config(notice: "기재된 정보는 주최사 사정에 따라 수시로 변동될 수 있으니 예매 전 꼭 확인 해주세요.")
    }
    
    lazy var problemBtn = UIButton().then{
        $0.setTitle("예매처로 이동이 안되시나요?", for: .normal)
        $0.tintColor = .white
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.addTarget(self, action: #selector(problemBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var moveToTargetBtn = UIButton().then{
        $0.backgroundColor = UIColor.Point.or01
        $0.setTitle("예매처로 이동", for: .normal)
        $0.tintColor = .white
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(moveToTarget(_:)), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        setUI()
    }
    
    //MARK: - Functions
    @objc func problemBtnPressed(_ sender: UIButton){
        print("예매처로 수동 이동인듯??")
    }
    
    @objc func moveToTarget(_ sender: UIButton){
        print("예매처로 이동")
    }
    
    func setUI(){
        self.view.addSubview(infoImageView)
        self.view.addSubview(stickView)
        self.view.addSubview(alertTitleLabel)
        self.view.addSubview(noticeView)
        self.view.addSubview(noticeViewTwo)
        self.view.addSubview(noticeViewThree)
        self.view.addSubview(problemBtn)
        self.view.addSubview(moveToTargetBtn)
        
        infoImageView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(130.0)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(32.0)
            $0.width.height.equalTo(24.0)
        }
        
        stickView.snp.makeConstraints{
            $0.top.equalTo(infoImageView.snp.bottom).offset(14.0)
            $0.leading.equalToSuperview().offset(32.0)
            $0.trailing.equalToSuperview().offset(-32.0)
            $0.height.equalTo(3.0)
        }
        
        alertTitleLabel.snp.makeConstraints{
            $0.top.equalTo(stickView.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(32.0)
        }
        
        noticeView.snp.makeConstraints{
            $0.top.equalTo(alertTitleLabel.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(32.0)
            $0.trailing.equalToSuperview().offset(-32.0)
        }
        
        noticeViewTwo.snp.makeConstraints{
            $0.top.equalTo(noticeView.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(32.0)
            $0.trailing.equalToSuperview().offset(-32.0)
        }
        
        noticeViewThree.snp.makeConstraints{
            $0.top.equalTo(noticeViewTwo.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(32.0)
            $0.trailing.equalToSuperview().offset(-32.0)
        }
        
        problemBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(moveToTargetBtn.snp.top).offset(-13.0)
        }
        
        moveToTargetBtn.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(24.0)
            $0.trailing.equalToSuperview().offset(-24.0)
            $0.bottom.equalToSuperview().offset(-64.0)
            $0.height.equalTo(48.0)
        }
    }
}
