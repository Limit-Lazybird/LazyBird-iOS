//
//  LoginViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/19.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

enum LoginType{
    case y
    case n
}

protocol LoginViewModelProtocol{
    func requestAppleLogin(token: Data, completion: @escaping (LoginType)->(Void))
}

class LoginViewModel: LoginViewModelProtocol {
    private let loginManager = LoginAPIManager.shared
    
    //MARK: - 소셜 로그인
    func requestAppleLogin(token: Data, completion: @escaping (LoginType)->(Void)){
        guard let tokenToString = String(data: token, encoding: .utf8) else {
            print("token is nil")
            return
        }
        let logReq = LoginRequest(comp_cd: "03", token: tokenToString)
        
        loginManager.requestAppleLogin(logReq: logReq){ response in
            print("apple login keychain 저장 --> \(response)")
            let token = TokenUtils.shared
            token.create(account: .comp_cd, value: "03")
            token.create(account: .refresh_token, value: response.refreshToken)
            token.create(account: .access_token, value: response.jwt.token)
            
            if response.useYN == "Y"{
                completion(.y)
            }else{
                completion(.n)
            }
        }
    }
    
    func requestKakaoLogin(oauthToken: OAuthToken, completion: @escaping (LoginType)->(Void)){
        let token = oauthToken.accessToken
        let loginRequest = LoginRequest(comp_cd: "01",token: token)
        print("login request result --> \(loginRequest)")
        
        loginManager.requestKakaoLogin(loginRequest: loginRequest) { response in
            print("kakao login keychain 저장 --> \(response)")
            let token = TokenUtils.shared
            
            token.create(account: .comp_cd, value: "01")
            token.create(account: .refresh_token, value: response.refreshToken)
            token.create(account: .access_token, value: response.jwt.token)
            
            if response.useYN == "Y"{
                completion(.y)
            }else{
                completion(.n)
            }
        }
    }
    
    init(){}
}
