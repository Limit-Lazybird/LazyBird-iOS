//
//  APIManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/18.
//

import UIKit
import Alamofire


class APIManager {
    static let shared = APIManager()
    
    private init() { }
    
    //MARK: - 소셜 로그인
    func requestAppleLogin(loginRequest: LoginRequest, completion: @escaping (LoginResponse)->(Void)){
        let requestURL = "https://limit-lazybird.com/oauth/apple"
        let query : [String: Any] = ["comp_cd":loginRequest.comp_cd,
                                     "email":loginRequest.email,
                                     "token":loginRequest.token,
                                     "name":loginRequest.name]
        
        AF.request(requestURL, method: .post, parameters: query, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
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
        let requestURL = "https://limit-lazybird.com/oauth/kakao"
        let query: [String: Any] = ["comp_cd":loginRequest.comp_cd,
                                    "email":loginRequest.email,
                                    "token":loginRequest.token,
                                    "name":loginRequest.name]
        
        AF.request(requestURL, method: .post, parameters: query, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
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
    
    
    // MARK: - 얼리버드 리스트 Request
    func requestEarlyBirdList(completion: @escaping (Exhibits)->(Void)){
        let testToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb21wX2NkIjoiMDEiLCJlbWFpbCI6IndsZG5qczk5MUBnbWFpbC5jb20iLCJuYW1lIjoiamVvbmppd29uIiwiaWF0IjoxNjM2ODE3MDYwfQ.2xn78SSB1Jxt6hofsUQst-VZQiNNLsstudVqhO4LCbo"
        let requestURL = "https://limit-lazybird.com/exhibit/earlyList"
       
        AF.request(requestURL, method: .post, parameters: ["token":testToken], encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    
                    let json = try JSONDecoder().decode(Exhibits.self, from: jsonData)
                    completion(json)
//                    let jsonToString = String(data: jsonData, encoding: .utf8)
//                    print("json -----> \(jsonToString)")
                    
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }//reqeust
    
    // MARK: - 전시회 리스트 Request
    func requestExhibitList(completion: @escaping (Exhibits)->(Void)){
        let testToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb21wX2NkIjoiMDEiLCJlbWFpbCI6IndsZG5qczk5MUBnbWFpbC5jb20iLCJuYW1lIjoiamVvbmppd29uIiwiaWF0IjoxNjM2ODE3MDYwfQ.2xn78SSB1Jxt6hofsUQst-VZQiNNLsstudVqhO4LCbo"
        let requestURL = "https://limit-lazybird.com/exhibit/list"
       
        AF.request(requestURL, method: .post, parameters: ["token":testToken], encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(Exhibits.self, from: jsonData)
                    
                    completion(json)
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }//reqeust
}
