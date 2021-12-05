//
//  APIManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/18.
//

import UIKit
import Alamofire


class LoginAPIManager {
    static let shared = LoginAPIManager()
    
    private init() { }
    
    //MARK: - 소셜 로그인
    func requestAppleLogin(logReq: LoginRequest, completion: @escaping (LoginResponse)->(Void)){
        let requestURL = "https://limit-lazybird.com/oauth/login"
        let query: [String: String] = ["comp_cd": logReq.comp_cd,
                                       "token": logReq.token]

        print("logReq token ---> \(logReq.token)")
        print("=-=-==-=--=--=-=-=-=-=-=-=-=-==-=-=")
        AF.request(requestURL, method: .post, parameters: query, encoding: JSONEncoding.default).validate(statusCode: 100..<600).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(LoginResponse.self, from: jsonData)
                    completion(json)
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
    
    func requestKakaoLogin(loginRequest: LoginRequest, completion: @escaping (LoginResponse)->(Void)){
        let requestURL = "https://limit-lazybird.com/oauth/login"
        let query: [String: String] = ["comp_cd": loginRequest.comp_cd,
                                       "token": loginRequest.token]
        
        AF.request(requestURL, method: .post, parameters: query, encoding: JSONEncoding.default).validate(statusCode: 100..<600).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(LoginResponse.self, from: jsonData)
                    completion(json)
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
}
