//
//  WithdrawalViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit
import SnapKit
import Then

class WithdrawalViewController: UIViewController {
    //MARK: - UI Components
    let withdrawalLabel = UILabel().then{
        $0.text = "탈퇴하기"
        $0.font = UIFont.TTFont(type: .SDBold, size: 24)
        $0.textColor = .white
    }
    
    let alertLabel = UILabel().then{
        $0.text = "탈퇴하기"
        $0.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.textColor = UIColor.Point.or01
    }
    
    let noticeViewOne = NoticeView().then{
        $0.config(notice: "회원탈퇴를 하시면 해당 계정에 대한 회원정보 및 서비스 정보는 모두 삭제되며, 즉시 탈퇴 처리되어 복구가 불가 합니다.")
    }
    
    let noticeViewTwo = NoticeView().then{
        $0.config(notice: "회원 탈퇴 후 동일 계정으로 재가입 가능하나, 기존에 저장된 정보가 모두 사라집니다.")
    }
    
    lazy var cancelBtn = UIButton().then{
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.backgroundColor = UIColor.Basic.gray01
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(cancelBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var withOutBtn = UIButton().then{
        $0.setTitle("탈퇴하기", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.backgroundColor = UIColor.Point.or01
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(withOutBtnPressed(_:)), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        setUI()
    }
    
    //MARK: - Functions
    @objc func cancelBtnPressed(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func withOutBtnPressed(_ sender: UIButton){
        //TODO: 화면 이동 -> 처음 로그인 화면으로
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .overFullScreen
        
        self.present(loginVC, animated: false, completion: nil) // 화면 띄우고
    }
    
    func setUI(){
        self.view.addSubview(withdrawalLabel)
        self.view.addSubview(alertLabel)
        self.view.addSubview(noticeViewOne)
        self.view.addSubview(noticeViewTwo)
        self.view.addSubview(cancelBtn)
        self.view.addSubview(withOutBtn)
        
        withdrawalLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(24.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        alertLabel.snp.makeConstraints{
            $0.top.equalTo(withdrawalLabel.snp.bottom).offset(24.0)
            $0.leading.equalToSuperview().offset(24.0)
        }
        
        noticeViewOne.snp.makeConstraints{
            $0.top.equalTo(alertLabel.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(24.0)
            $0.trailing.equalToSuperview().offset(-24.0)
        }
        
        noticeViewTwo.snp.makeConstraints{
            $0.top.equalTo(noticeViewOne.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(24.0)
            $0.trailing.equalToSuperview().offset(-24.0)
        }
        
        cancelBtn.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(32.0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-32.0)
            $0.trailing.equalTo(withOutBtn.snp.leading).offset(-12.0)
            $0.height.equalTo(48.0)
        }
        
        withOutBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-32.0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-32.0)
            $0.width.equalTo(cancelBtn.snp.width)
            $0.height.equalTo(48.0)
        }
    }
}
