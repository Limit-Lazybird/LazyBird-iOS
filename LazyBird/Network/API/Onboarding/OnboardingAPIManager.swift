//
//  OnboardingAPIManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit
import Alamofire

class OnboardingAPIManager {
    static let shared = OnboardingAPIManager()
    
//    private init() { }
    
    // 설문 질문 request
    func requestOnboardQuestions(completion: @escaping (AnalysisQuestions)->(Void)){
        let testToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb21wX2NkIjoiMDEiLCJlbWFpbCI6IndsZG5qczk5MUBnbWFpbC5jb20iLCJuYW1lIjoiamVvbmppd29uIiwiaWF0IjoxNjM2ODE3MDYwfQ.2xn78SSB1Jxt6hofsUQst-VZQiNNLsstudVqhO4LCbo"
        let requestURL = "https://limit-lazybird.com/customized/list"
        let testParameter = OnboardingRequest(comp_cd: "03", email: "tnddls2ek@naver.com", token: testToken, name: "이숭인")
       
        AF.request(requestURL, method: .post, parameters: testParameter.toDictionary, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    
                    let json = try JSONDecoder().decode(AnalysisQuestions.self, from: jsonData)
                    completion(json)
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
    
    // 설문 결과 서버로 전송 request
    func requestQuestionAnswer(userInput: String){
        let testToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb21wX2NkIjoiMDEiLCJlbWFpbCI6IndsZG5qczk5MUBnbWFpbC5jb20iLCJuYW1lIjoiamVvbmppd29uIiwiaWF0IjoxNjM2ODE3MDYwfQ.2xn78SSB1Jxt6hofsUQst-VZQiNNLsstudVqhO4LCbo"
        let requestURL = "https://limit-lazybird.com/customized/listSave"
        let testParameter = QuestionInsertRequest(token: testToken, answer_idx: userInput)
       
        AF.request(requestURL, method: .post, parameters: testParameter.toDictionary, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
//                    let jsonToString = String(data: jsonData, encoding: .utf8)
//                    print("json To Strign ----- > \(jsonToString)")
//                    let json = try JSONDecoder().decode(AnalysisQuestions.self, from: jsonData)
//                    completion(json)
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
}
