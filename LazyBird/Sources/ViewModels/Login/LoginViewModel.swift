//
//  LoginViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/19.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

protocol LoginViewModelProtocol{
    func requestAppleLogin(email: String, token: Data, name: PersonNameComponents)
}

class LoginViewModel: LoginViewModelProtocol {
    private let apiManager = APIManager.shared
    
    //MARK: - 소셜 로그인
    func requestAppleLogin(email: String, token: Data, name: PersonNameComponents){
        guard let token = String(data: token, encoding: .utf8) else {
            print("token is nil")
            return
        }
        guard let givenName = name.givenName else {
            print("givenName is nil")
            return
        }
        guard let familyName = name.familyName else {
            print("familyName is nil")
            return
        }
        let loginRequest = LoginRequest(comp_cd: "03", email: email, token: token, name: familyName + givenName)
        
        apiManager.requestAppleLogin(loginRequest: loginRequest){ response in
            print("login response data --> \(response)")
        }
    }
    
    func requestKakaoLogin(oauthToken: OAuthToken, user: User){
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
        
        let loginRequest = LoginRequest(comp_cd: "01", email: email, token: token, name: name)
        
        apiManager.requestKakaoLogin(loginRequest: loginRequest) { response in
            print("kakao login response data --> \(response)")
        }
    }
    
    init(){}
}
