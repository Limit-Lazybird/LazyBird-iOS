//
//  ViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/18.
//

import UIKit
import SnapKit
import Then
import AuthenticationServices
import GoogleSignIn
import KakaoSDKUser

class LoginViewController: UIViewController {
    lazy var logoContainerView: LogoContainerView = LogoContainerView(frame: .zero).then{
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.layer.borderWidth = 1.0
        $0.layer.backgroundColor = UIColor.Opacity.black30.cgColor
        $0.layer.borderColor = UIColor.Basic.gray01.cgColor
    }
    
    lazy var loginButtonContainerView: LoginButtonContainerView = LoginButtonContainerView(frame: .zero)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        loginButtonContainerView.setViewController(self) // containerView에 viewcontroller 주소 넘겨줌
        
        setupLayout()
    }
    
    func setupLayout(){
        self.view.addSubview(logoContainerView)
        self.view.addSubview(loginButtonContainerView)
        
        logoContainerView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.view.frame.height * 0.6908866995)
            $0.bottom.equalTo(loginButtonContainerView.snp.top)
        }
        
        loginButtonContainerView.snp.makeConstraints{
            $0.leading.equalTo(self.view.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(self.view.frame.height * 0.30911330049)
            $0.bottom.equalToSuperview()
        }
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        print("delegate 호출됨")
        switch authorization.credential {
        // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                
            // 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
//            let test = appleIDCredential.identityToken // id token
//            let test2 = appleIDCredential.realUserStatus // 사용자 상태
//            let test3 = appleIDCredential.authorizationCode // auth code
            
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
     
        default:
            break
        }
    }
        
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

