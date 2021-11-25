//
//  KakaoLoginManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/20.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon 

class KakaoLoginManager: NSObject {
    private var vc: UIViewController?
    
    // Kakao Login Button Pressed
    func login(completion: @escaping ([String:Any])->(Void)){
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                //TODO: 서버로 토큰 보내기
    
                UserApi.shared.me() {(user, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("me() success.")
                        guard let oauthToken = oauthToken else {
                            print("oauthToken is nil")
                            return
                        }
                        guard let user = user else {
                            print("user is nil")
                            return
                        }

                        completion(["oauthToken": oauthToken, "user": user])
                    }
                }
            }
        }
    }
    
    // Kakao Auto Login
    func autoLogin(completion: @escaping (Bool)->(Void)){
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (accessToken, error) in
                if let error = error {
                    // 토큰 존재하지만 만료된 토큰일 경우 다시 로그인
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //TODO: 로그인 필요
                        print("로그인 필요")
                        completion(false)
                    }
                    else {
                        //TODO:  로그인 도중 취소라던지 여러가지 이유로 인한 에러 처리
                        print("에러 발생")
                        completion(false)
                    }
                }
                else {
                    //토큰 존재 o , 토큰 유효성 체크 성공 (필요시 자동으로 토큰 갱신)
                    //TODO: 3. 로그인 성공 (토큰이 유효)
                    
                    let token = TokenUtils.shared
                    if let _ = token.read(account: .access_token) {
                        completion(true)
                    }else{
                        print("token 없음")
                        //TODO: 다시 서버로 로그인 요청해야함 일단은 ㄴㅇㄱ
                        completion(false)
                    }
                    
                }
            }
        }
        else {
            //TODO: 로그인 필요
            print("로그인 필요")
            completion(false)
        }
    }
}

extension KakaoLoginManager {
    func setViewController(_ vc: UIViewController?){
        self.vc = vc
    }
}
