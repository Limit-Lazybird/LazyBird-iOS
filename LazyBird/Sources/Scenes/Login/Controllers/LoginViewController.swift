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
    lazy var loginButtonContainerView: LoginButtonContainerView = LoginButtonContainerView(frame: .zero)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        loginButtonContainerView.setViewController(self) // containerView에 viewcontroller 주소 넘겨줌
        setupLayout()
        
    }
    
    func setupLayout(){
        self.view.addSubview(loginButtonContainerView)
        
        loginButtonContainerView.snp.makeConstraints{
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16.0)
            $0.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(16.0)
            $0.height.equalTo(120.0)
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

