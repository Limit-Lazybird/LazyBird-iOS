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
    
    func requestCustomExhibitList(completion: @escaping (Exhibits)->(Void)){
        let testToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb21wX2NkIjoiMDEiLCJlbWFpbCI6IndsZG5qczk5MUBnbWFpbC5jb20iLCJuYW1lIjoiamVvbmppd29uIiwiaWF0IjoxNjM2ODE3MDYwfQ.2xn78SSB1Jxt6hofsUQst-VZQiNNLsstudVqhO4LCbo"
        let requestURL = "https://limit-lazybird.com/exhibit/customList"
       
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
