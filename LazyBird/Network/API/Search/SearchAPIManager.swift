//
//  SearchAPIManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit
import Alamofire

class SearchAPIManager{
    static let shared = SearchAPIManager()
    private init() {}
    
    func requestSearchedExhibitList(word: String, completion: @escaping (Exhibits)->(Void)){
        guard let token = TokenUtils.shared.read(account: .access_token) else {
            print("requestSearchedExhibitList token is nil")
            return
        }
        let requestURL = "https://limit-lazybird.com/exhibit/searchList"
        let query = ["token": token,
                     "words": word]
        
        AF.request(requestURL, method: .post, parameters: query, encoding: JSONEncoding.default).validate(statusCode: 100..<600).responseJSON { response in
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
