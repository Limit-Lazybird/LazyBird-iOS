//
//  LoginButtonContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/20.
//

import UIKit
import Then
import SnapKit
import GoogleSignIn
import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKUser

class LoginButtonContainerView: UIView {
    var viewController: UIViewController?
    var viewModel: LoginViewModel?
    
    private let kakaoLoginManager = KakaoLoginManager()
    private let googleLoginManager = GoogleLoginManager()
    private let appleLoginManager = AppleLoginManager()
    
    let loginLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.text = "로그인"
        $0.textColor = .white
    }
    
    // 로그인 버튼들을 넣을 stackView
    lazy var stackView = UIStackView().then{
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 12
    }
    // 카카오 로그인 버튼
    lazy var kakaoLoginBtn = UIButton().then{
        
        $0.setBackgroundImage(UIImage(named: "kakaoLoginBtn"), for: .normal)
        $0.addTarget(self, action: #selector(kakaoLogin(_:)), for: .touchUpInside)
    }
  
    // 애플 로그인 버튼
    lazy var appleLoginBtn = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "appleLoginBtn"), for: .normal)
        $0.addTarget(self, action: #selector(appleLogin), for: .touchUpInside)
    }
    
    @objc func kakaoLogin(_ sender: UIButton){
        guard let vc = self.viewController else { return }
        guard let viewModel = viewModel else { return }

        kakaoLoginManager.setViewController(vc)
        // 서버로 request
        kakaoLoginManager.login(){ response in
            let oauthToken = response["oauthToken"] as! OAuthToken
            let user = response["user"] as! User
            viewModel.requestKakaoLogin(oauthToken: oauthToken, user: user){ response in
                switch response{
                case .y:
                    let onboardVC = StartOnboardingViewController()
                    onboardVC.modalPresentationStyle = .overFullScreen
                    
                    vc.present(onboardVC, animated: true, completion: nil)
                    break
                case .n:
                    let tabbarVC = TabBarViewController()
                    tabbarVC.modalPresentationStyle = .overFullScreen
                    
                    vc.present(tabbarVC, animated: true, completion: nil)
                    break
                }
            }
        }
    }

    @objc func appleLogin(_ sender: UIButton){
        guard let vc = self.viewController else { return }
        
        appleLoginManager.setViewController(vc)
        appleLoginManager.login()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        self.addSubview(loginLabel)
        self.addSubview(stackView)
        stackView.addArrangedSubview(appleLoginBtn)
        stackView.addArrangedSubview(kakaoLoginBtn)
        
        
        loginLabel.snp.makeConstraints{
            $0.leading.equalTo(stackView.snp.leading).offset(2.0)
            $0.centerY.equalTo(stackView).multipliedBy(0.25)
        }

        stackView.snp.makeConstraints{
            $0.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(45.0)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(45.0)
        }

        kakaoLoginBtn.snp.makeConstraints{
            $0.height.equalTo(stackView.snp.width).multipliedBy(0.14035087719)

        }
        appleLoginBtn.snp.makeConstraints{
            $0.height.equalTo(stackView.snp.width).multipliedBy(0.14035087719)
        }
    }
}

extension LoginButtonContainerView {
    // 이러케하면 뭐 문제될건 없는데 찝찝하다 결합략이 너무 강함... 좀더 느슨하게는 안될까?
    func setViewController(_ vc: UIViewController){
        self.viewController = vc
    }
    
    func setLoginViewModel(_ viewModel: LoginViewModel){
        self.viewModel = viewModel
    }
}
