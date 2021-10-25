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

class LoginButtonContainerView: UIView {
    var viewController: UIViewController?
    private let kakaoLoginManager = KakaoLoginManager()
    private let googleLoginManager = GoogleLoginManager()
    private let appleLoginManager = AppleLoginManager()
    
    // 로그인 버튼들을 넣을 stackView
    lazy var stackView = UIStackView().then{
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 0
    }
    // 카카오 로그인 버튼
    lazy var kakaoLoginButton = UIButton().then{
        $0.setTitle("카카오 로그인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(kakaoLogin(_:)), for: .touchUpInside)
    }
    // 구글 로그인 버튼
    lazy var googleLoginButton = GIDSignInButton().then{
        $0.style = .wide
        $0.addTarget(self, action: #selector(googleLogin(_:)), for: .touchUpInside)
    }
    // 애플 로그인 버튼
    lazy var authorizationButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black).then{
        $0.addTarget(self, action: #selector(appleLogin), for: .touchUpInside)
    }
    
    @objc func kakaoLogin(_ sender: UIButton){
        kakaoLoginManager.login()
    }
    @objc func googleLogin(_ sender: UIButton){
        guard let vc = self.viewController else { return }
        
        googleLoginManager.setViewController(vc)
        googleLoginManager.login()
    }
    @objc func appleLogin(_ sender: UIButton){
        guard let vc = self.viewController else { return }
        
        appleLoginManager.setViewController(vc)
        appleLoginManager.login()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        self.addSubview(stackView)
        stackView.addArrangedSubview(kakaoLoginButton)
        stackView.addArrangedSubview(googleLoginButton)
        stackView.addArrangedSubview(authorizationButton)
        
        stackView.snp.makeConstraints{
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        kakaoLoginButton.snp.makeConstraints{
            $0.height.equalTo(40.0)
        }
        googleLoginButton.snp.makeConstraints{
            $0.height.equalTo(40.0)
        }
        authorizationButton.snp.makeConstraints{
            $0.height.equalTo(40.0)
        }
    }
}

extension LoginButtonContainerView {
    // 이러케하면 뭐 문제될건 없는데 찝찝하다 결합략이 너무 강함... 좀더 느슨하게는 안될까?
    func setViewController(_ vc: UIViewController){
        self.viewController = vc
    }
}
