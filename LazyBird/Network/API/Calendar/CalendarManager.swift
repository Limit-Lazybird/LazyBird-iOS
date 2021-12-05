//
//  CalendarManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/03.
//

import UIKit
import Alamofire

class CalendarManager {
    static let shared = CalendarManager()
    private init(){}
    
    /* 캘린더에 저장된 전시 예약 정보 (월별) Request */
    func requestSchedules(reser_dt: String, completion: @escaping (Schedules)->(Void)){ // 찾고자 하는 년월 문자열
        guard let token = TokenUtils.shared.read(account: .access_token) else{
            print("requestLike  token read is nil")
            return
        }
        let requestURL = "https://limit-lazybird.com/calender/registList"
        let parameter = ["token": token,
                         "reser_dt": reser_dt]
       
        AF.request(requestURL, method: .post, parameters: parameter, encoding: JSONEncoding.default).validate(statusCode: 100..<600).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(Schedules.self, from: jsonData)
                    
                    completion(json)
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
    
    /* 예약이 된 전시지만 캘린더에 등록이 안된 리스트를 출력하는 API입니다. */
    func requestUnregistedSchedules(completion: @escaping (Schedules)->(Void)){
        guard let token = TokenUtils.shared.read(account: .access_token) else{
            print("requestLike  token read is nil")
            return
        }
        let requestURL = "https://limit-lazybird.com/calender/unRegistList"
        let parameter = ["token": token]
        
        AF.request(requestURL, method: .post, parameters: parameter, encoding: JSONEncoding.default).validate(statusCode: 100..<600).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(Schedules.self, from: jsonData)
                    
                    completion(json)
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
    
    /* 직접 등록하는 일정 전시 캘린더에 등록 */
    func requestSaveCustomSchedule(customSchedule: CustomInfoSaveRequest){
        guard let token = TokenUtils.shared.read(account: .access_token) else{
            print("requestLike  token read is nil")
            return
        }
        let requestURL = "https://limit-lazybird.com/calender/customInfoSave"
        var schedule = customSchedule
        schedule.updateDict(token: token)
        let parameter = schedule.toDict
        
        AF.request(requestURL, method: .post, parameters: parameter, encoding: JSONEncoding.default).validate(statusCode: 100..<600).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    let jsonToString = String(data: jsonData, encoding: .utf8)
                    print("requestSaveCustomSchedule result -> \(jsonToString ?? "")")
//                    let json = try JSONDecoder().decode(Schedules.self, from: jsonData)
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
}
