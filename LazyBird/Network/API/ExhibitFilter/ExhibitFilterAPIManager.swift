//
//  ExhibitFilterAPIManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit
import Alamofire

class ExhibitFilterAPIManager {
    static let shared = ExhibitFilterAPIManager()
    private init() { }
    let tokenUtils = TokenUtils.shared
    
    func requestExhibitDTL(searchList: String, completion: @escaping (Exhibits)->(Void)){
        guard let token = tokenUtils.read(account: .access_token) else {
            print("requestExhibitDTL token read is nil")
            return
        }
        
        let requestURL = "https://limit-lazybird.com/exhibit/detailList"
        let parameter = ["token": token,
                             "searchList": searchList]
        print("serach Items --> \(searchList)")
        
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
}
