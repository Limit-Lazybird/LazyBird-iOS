//
//  UserInfoAPIManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit
import Alamofire

class UserInfoAPIManager {
    static let shared = UserInfoAPIManager()
    private init() {}
    
    
    func requestUserInfo(completion: @escaping (UserInfo)->(Void)){
        let requestURL = "https://limit-lazybird.com/status/userInfo"
        
        guard let token = TokenUtils.shared.read(account: .access_token) else{
            print("requestUserInfo token is nil")
            return
        }
        
        let query = ["token": token]
        
        AF.request(requestURL, method: .post, parameters: query, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(UserInfo.self, from: jsonData)
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
