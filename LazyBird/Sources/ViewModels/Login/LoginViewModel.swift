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
//    func requestAppleLogin(email: String, name: PersonNameComponents, token: Data, completion: @escaping (LoginType)->(Void))
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
//        let logReq = LoginRequest(comp_cd: "03", email: email, token: tokenToString, name: name.givenName ?? "")
        
        loginManager.requestAppleLogin(logReq: logReq){ response in
            print("apple login keychain 저장 --> \(response)")
            let token = TokenUtils.shared
            token.create(account: .access_token, value: response.jwt.token)
            
            if response.useYN == "Y"{
                completion(.y)
            }else{
                completion(.n)
            }
        }
    }
    
    func requestKakaoLogin(oauthToken: OAuthToken, user: User, completion: @escaping (LoginType)->(Void)){
        // email, name, token
        guard let kakaoAccount = user.kakaoAccount else {
            print("kakao Account is nil")
            return
        }
        guard let email = kakaoAccount.email else {
            print("email is nil")
            return
        }
        guard let profile = kakaoAccount.profile else {
            print("profile is nil")
            return
        }
        guard let name = profile.nickname else {
            print("nickname is nil")
            return
        }
        
        let token = oauthToken.accessToken
        let loginRequest = LoginRequest(comp_cd: "01",token: token)
        print("login request result --> \(loginRequest)")
        
        TokenUtils.shared.create(account: .comp_cd, value: "01")
        TokenUtils.shared.create(account: .email, value: email)
        TokenUtils.shared.create(account: .name, value: name)
        
        loginManager.requestKakaoLogin(loginRequest: loginRequest) { response in
            print("kakao login keychain 저장 --> \(response)")
            let token = TokenUtils.shared
            
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
