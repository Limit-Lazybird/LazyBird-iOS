//
//  MyBirdAPIManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit
import Alamofire

class MyBirdAPIManager {
    static let shared = MyBirdAPIManager()
    private init() {}
    let tokenUtils = TokenUtils.shared
    
    // 찜한 전시 리스트
    func requestFavoriteExhibitList(completion: @escaping (Exhibits)->(Void)){
        guard let token = tokenUtils.read(account: .access_token) else{
            print("requestCustomExhibitList  token read is nil")
            return
        }
        let requestURL = "https://limit-lazybird.com/status/likeList"
        let parameter = ["token": token]
       
        AF.request(requestURL, method: .post, parameters: parameter, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
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
    
    func requestReservationExhibits(completion: @escaping (Exhibits)->(Void)){
        guard let token = tokenUtils.read(account: .access_token) else{
            print("requestCustomExhibitList  token read is nil")
            return
        }
        let requestURL = "https://limit-lazybird.com/status/reservationList"
        let parameter = ["token": token,
                         "state_cd": "20"]
       
        AF.request(requestURL, method: .post, parameters: parameter, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
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
    }
}
