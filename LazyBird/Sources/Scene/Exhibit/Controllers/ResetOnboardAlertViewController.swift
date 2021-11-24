//
//  ResetOnboardAlertViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/24.
//

import UIKit
import SnapKit
import Then


class ResetOnboardAlertViewController: UIViewController {
    //MARK: - UI Components
    lazy var bgView = UIView().then{
        $0.backgroundColor = UIColor.Opacity.black80
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(emptyViewTapped(_:))))
    }
    
    let contentView = UIView().then{
        $0.backgroundColor = UIColor.Background.darkGray02
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 20
    }
    
    let alertTitleLabel = UILabel().then{
        $0.text = "전시 성향 분석을 재설정하겠습니까?"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = .white
    }
    
    let alertContentLabel = UILabel().then{
        $0.text = "재설정 진행 시 이전의 전시 성향 분석 결과는 삭제되며 새롭게 입력된 정보로 다시 설정됩니다."
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    lazy var resetBtn = UIButton().then{
        $0.setTitle("재설정하기", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.backgroundColor = UIColor.Point.or01
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(resetBtnPressed(_:)), for: .touchUpInside)
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        setUI()
    }
    
    //MARK: - Functions
    @objc func resetBtnPressed(_ sender: UIButton){
        //TODO: 화면 이동 -> 처음 온보딩 화면으로
        let startOnboard = StartOnboardingViewController()
        startOnboard.parentType = .reset
        
        let onboardVC = UINavigationController(rootViewController: startOnboard)
        onboardVC.modalPresentationStyle = .overFullScreen
        
        self.present(onboardVC, animated: true, completion: nil) // 화면 띄우고
    }
    
    @objc func emptyViewTapped(_ sender: Any){
        self.dismiss(animated: false, completion: nil)
    }
    
    func setUI(){
        self.view.addSubview(bgView)
        self.view.addSubview(contentView)
        contentView.addSubview(alertTitleLabel)
        contentView.addSubview(alertContentLabel)
        contentView.addSubview(resetBtn)
        
        bgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(221.0)
        }
        
        alertTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-56.0)
        }
        
        alertContentLabel.snp.makeConstraints{
            $0.top.equalTo(alertTitleLabel.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
        }
        
        resetBtn.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-56.0)
            $0.height.equalTo(48.0)
        }
    }

}
