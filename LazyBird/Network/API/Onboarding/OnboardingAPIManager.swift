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
    private init() { }
    let tokenUtils = TokenUtils.shared
    
    // 설문 질문 request
    func requestOnboardQuestions(completion: @escaping (AnalysisQuestions)->(Void)){
        let requestURL = "https://limit-lazybird.com/customized/list"
        guard let token = tokenUtils.read(account: .access_token) else {
            print("requestOnboardQuestions token read is nil")
            return
        }
        let parameter = ["token": token]
       
        AF.request(requestURL, method: .post, parameters: parameter, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
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
        let token = tokenUtils.read(account: .access_token) ?? ""
        let requestURL = "https://limit-lazybird.com/customized/listSave"
        let testParameter = QuestionInsertRequest(token: token, answer_idx: userInput)
       
        AF.request(requestURL, method: .post, parameters: testParameter.toDictionary, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let _ = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    
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
