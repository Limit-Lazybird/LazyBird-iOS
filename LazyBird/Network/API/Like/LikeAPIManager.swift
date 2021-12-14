//
//  LikeAPIManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit
import Alamofire

class LikeAPIManager {
    static let shared = LikeAPIManager()
    private init() {}
    
    let tokenUtils = TokenUtils.shared
    
    // 좋아요 요청
    func requestLike(exhbt_cd: String, like_yn: String, completion: @escaping ()->(Void)){
        guard let token = tokenUtils.read(account: .access_token) else{
            print("requestLike  token read is nil")
            return
        }
        let requestURL = "https://limit-lazybird.com/status/likeSave"
        let parameter = ["token": token,
                         "exhbt_cd": exhbt_cd,
                         "like_yn": like_yn]
       print("like request exhbt_cd ----> \(exhbt_cd)")
        
        AF.request(requestURL, method: .post, parameters: parameter, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                print("좋아요 요청 전송 성공")
                completion()
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
    
    // 좋아요 요청
    func requestLikeCancel(exhbt_cd: String, completion: @escaping ()->(Void)){
        guard let token = tokenUtils.read(account: .access_token) else{
            print("requestLike  token read is nil")
            return
        }
        let requestURL = "https://limit-lazybird.com/status/likeDel"
        let parameter = ["token": token,
                         "exhbt_cd": exhbt_cd]
        print("like cancel request exhbt_cd ----> \(exhbt_cd)")
        AF.request(requestURL, method: .post, parameters: parameter, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                print("좋아요 취소 전송 성공")
                completion()
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
}
