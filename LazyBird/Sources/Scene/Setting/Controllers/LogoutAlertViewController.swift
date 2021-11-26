//
//  LogoutAlertViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit

class LogoutAlertViewController: UIViewController {
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
        $0.text = "로그아웃 하시겠습니까?"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = .white
    }
    
    lazy var logoutBtn = UIButton().then{
        $0.setTitle("로그아웃 할게요", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.backgroundColor = UIColor.Point.or01
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(logoutBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var cancelBtn = UIButton().then{
        $0.setTitle("아니오", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.backgroundColor = UIColor.Basic.gray01
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(cancelBtnPressed(_:)), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        setUI()
    }

    //MARK: - Functions
    @objc func cancelBtnPressed(_ sender: UIButton){
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func logoutBtnPressed(_ sender: UIButton){
        //TODO: 화면 이동 -> 처음 온보딩 화면으로
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .overFullScreen
        
        self.present(loginVC, animated: false, completion: nil) // 화면 띄우고
    }
    
    @objc func emptyViewTapped(_ sender: Any){
        self.dismiss(animated: false, completion: nil)
    }
    
    func setUI(){
        self.view.addSubview(bgView)
        self.view.addSubview(contentView)
        contentView.addSubview(alertTitleLabel)
        contentView.addSubview(cancelBtn)
        contentView.addSubview(logoutBtn)
        
        bgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(250.0)
        }
        
        alertTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-56.0)
        }
        
        cancelBtn.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.height.equalTo(48.0)
        }
        
        logoutBtn.snp.makeConstraints{
            $0.top.equalTo(cancelBtn.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-56.0)
            $0.height.equalTo(48.0)
        }
    }
}
