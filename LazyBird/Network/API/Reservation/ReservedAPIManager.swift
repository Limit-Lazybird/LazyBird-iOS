//
//  ReservedAPIManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit
import Alamofire

class ReservedAPIManager {
    static let shared = ReservedAPIManager()
    private init(){}
    let tokenUtils = TokenUtils.shared
    
    /* 전시회 예약 */
    func requestReserved(exhbt_cd: String, state_cd: String){
        guard let token = tokenUtils.read(account: .access_token) else{
            print("requestLike  token read is nil")
            return
        }
        let requestURL = "https://limit-lazybird.com/status/reservationSave"
        let parameter = ["token": token,
                         "exhbt_cd": exhbt_cd,
                         "state_cd": state_cd]
       
        AF.request(requestURL, method: .post, parameters: parameter, encoding: JSONEncoding.default).validate(statusCode: 100..<600).responseJSON { response in
            switch response.result {
            case .success:
                print("예약 요청 전송 성공")
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
    
    /* 예약된 전시 삭제 */
    func requestReservedExhibitionRemove(exhbt_cd: String , completion: @escaping ()->(Void)){
        guard let token = TokenUtils.shared.read(account: .access_token) else{
            print("requestLike  token read is nil")
            return
        }
        let requestURL = "https://limit-lazybird.com/status/reservationDel"
        let parameter = ["token":token,
                         "exhbt_cd":exhbt_cd]
        
        AF.request(requestURL, method: .post, parameters: parameter, encoding: JSONEncoding.default).validate(statusCode: 100..<600).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    let jsonToString = String(data: jsonData, encoding: .utf8)
                    print("requestSaveCustomSchedule result -> \(jsonToString ?? "")")
                    completion()
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
}
