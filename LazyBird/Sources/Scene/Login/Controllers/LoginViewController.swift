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
    // test
    let apiManager = LoginAPIManager.shared
    let loginViewModel = LoginViewModel()
    
    lazy var logoContainerView: LogoContainerView = LogoContainerView(frame: .zero).then{
        $0.backgroundColor = UIColor.Background.black02
    }
    
    lazy var loginButtonContainerView: LoginButtonContainerView = LoginButtonContainerView(frame: .zero)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        loginButtonContainerView.setViewController(self) // containerView에 viewcontroller 주소 넘겨줌
        loginButtonContainerView.setLoginViewModel(self.loginViewModel)
        
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
            let token = appleIDCredential.identityToken // id token
            
            guard let token = token else {
                print("token is nil")
                return
            }

            
            self.loginViewModel.requestAppleLogin(token: token){ response in
                print("request??")
                switch response {
                case .y:  // 이미 성향 분석이 되어있다면
                    let tabbarVC = TabBarViewController()
                    tabbarVC.modalPresentationStyle = .fullScreen
                    
                    self.present(tabbarVC, animated: true, completion: nil)
                    break
                case .n: // 성향 분석이 되어있지 않다면
                    let onboardVC = UINavigationController(rootViewController: StartOnboardingViewController())
                    onboardVC.modalPresentationStyle = .fullScreen
                    
                    self.present(onboardVC, animated: true, completion: nil)
                    break
                }
            }
        default:
            break
        }
    }
        
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("애플 id 연동 실패")
    }
}

