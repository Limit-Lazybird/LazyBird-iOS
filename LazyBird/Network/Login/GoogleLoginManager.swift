//
//  GoogleLoginManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/20.
//

import UIKit
import GoogleSignIn

class GoogleLoginManager: NSObject {
    private let signInConfig = GIDConfiguration.init(clientID: "633030545315-c88jbkrq02ljeuu0lk3kv7hfemcrv1bn.apps.googleusercontent.com")
    private var vc: UIViewController?
    
    func login(){
        guard let vc = self.vc else { return }
        // 로그인 요청
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: vc) { user, error in
            guard error == nil else { return }
            
            print("로그인 성공 ===========")
            
            user?.authentication.do { authentication, error in
                guard error == nil else { return }
                // guard let authentication = authentication else { return }
                // TODO: 토큰 보내기, 응답으로 자체 서비스 토큰 받아와 키체인 저장
            }
        }
    }
}

extension GoogleLoginManager {
    func getSignInConfig() -> GIDConfiguration {
        return self.signInConfig
    }
    func setViewController(_ vc: UIViewController?){
        self.vc = vc
    }
}
