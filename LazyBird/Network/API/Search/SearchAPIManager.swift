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
    
    func requestSearchedExhibitList(word: String, completion: @escaping (SearchedExhibits)->(Void)){
        let testToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb21wX2NkIjoiMDEiLCJlbWFpbCI6IndsZG5qczk5MUBnbWFpbC5jb20iLCJuYW1lIjoiamVvbmppd29uIiwiaWF0IjoxNjM2ODE3MDYwfQ.2xn78SSB1Jxt6hofsUQst-VZQiNNLsstudVqhO4LCbo"
        let requestURL = "https://limit-lazybird.com/exhibit/searchList"
        let testParameter = ["token": testToken,
                             "words": word]
        
        AF.request(requestURL, method: .post, parameters: testParameter, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    
                    let json = try JSONDecoder().decode(SearchedExhibits.self, from: jsonData)
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
