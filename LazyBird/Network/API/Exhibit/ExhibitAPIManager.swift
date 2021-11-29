//
//  ExhibitAPIManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/24.
//

import UIKit
import Alamofire

class ExhibitAPIManager {
    static let shared = ExhibitAPIManager()
    private init() { }
    let tokenUtils = TokenUtils.shared
    
    // MARK: - 얼리버드 리스트 Request
    func requestEarlyBirdList(completion: @escaping (Exhibits)->(Void)){
        guard let token = tokenUtils.read(account: .access_token) else {
            print("requestEarlyBirdList  token read is nil")
            return
        }
        print("test wldnfrjdo !!!!!---> \(tokenUtils.read(account: .access_token))")
        let requestURL = "https://limit-lazybird.com/exhibit/earlyList"
       
        AF.request(requestURL, method: .post, parameters: ["token":token], encoding: JSONEncoding.default).validate(statusCode: 100..<600).responseJSON { response in
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
    
    // MARK: - 전시회 리스트 Request
    func requestExhibitList(completion: @escaping (Exhibits)->(Void)){
        guard let token = tokenUtils.read(account: .access_token) else {
            print("requestExhibitList token read is nil")
            return
        }
        let requestURL = "https://limit-lazybird.com/exhibit/list"
       
        AF.request(requestURL, method: .post, parameters: ["token":token], encoding: JSONEncoding.default).validate(statusCode: 100..<600).responseJSON { response in
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
    
    // 전시 성향 맞춘 커스텀 전시 리스트
    func requestCustomExhibitList(completion: @escaping (Exhibits)->(Void)){
        guard let token = tokenUtils.read(account: .access_token) else{
            print("requestCustomExhibitList  token read is nil")
            return
        }
        let requestURL = "https://limit-lazybird.com/exhibit/customList"
       
        AF.request(requestURL, method: .post, parameters: ["token":token], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    let jsonToString = String(data: jsonData, encoding: .utf8)
                    print("json to string --> \(jsonToString)")
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
