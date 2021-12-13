//
//  EarlyCardManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/14.
//

import UIKit
import Alamofire

class EarlyCardManager {
    static let shared = EarlyCardManager()
    
    private init() {}
    
    /* 얼리카드 목록 호출 API */
    func requestEarlyCardList(completion: @escaping (EarlyCards)->(Void)){
        guard let token = TokenUtils.shared.read(account: .access_token) else{
            print("requestLike  token read is nil")
            return
        }
        
        let requestURL = "https://limit-lazybird.com/status/earlyCardList"
        let parameter = ["token":token]
        
        AF.request(requestURL, method: .post, parameters: parameter, encoding: JSONEncoding.default).validate(statusCode: 100..<600).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(EarlyCards.self, from: jsonData)
                    
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
