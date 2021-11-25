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
    
    func requestExhibitDTL(searchList: String){
        let testToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb21wX2NkIjoiMDEiLCJlbWFpbCI6ImthbjUwMTZAbmF2ZXIuY29tIiwibmFtZSI6IuyghOqzhOybkCIsImlhdCI6MTYzNzc1NTUxMCwiZXhwIjoxNjM3ODM4MzEwLCJpc3MiOiJqZW9uaml3b24ifQ.BXYAmVumtuLFoq90y-den6o3cGUOC3Atca9aFBzSWcU"
        let requestURL = "https://limit-lazybird.com/exhibit/detailList"
        let testparameter = ["token": testToken,
                             "searchList": searchList]
        
        
        AF.request(requestURL, method: .post, parameters: testparameter, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    
//                    let json = try JSONDecoder().decode(Exhibits.self, from: jsonData)
//                    completion(json)
                    let jsonToString = String(data: jsonData, encoding: .utf8)
                    print("json -----> \(jsonToString)")
                    
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }//reqeust
}
