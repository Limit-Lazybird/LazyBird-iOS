//
//  TokenUtils.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/23.
//

import Security
import Alamofire

enum accountType: String{
    case access_token = "access_token"
    case comp_cd = "comp_cd"
    case email = "email"
    case name = "name"
}

class TokenUtils {
    static let shared = TokenUtils()
    private init(){}
    
    let serviceURL = "https://limit-lazybird.com/"
    
    // Create
    // service 파라미터는 url주소를 의미
    func create(account: accountType, value: String) {
        // 1. query작성
        let keyChainQuery: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService: serviceURL + account.rawValue,
            kSecAttrAccount: account.rawValue,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]
        // allowLossyConversion은 인코딩 과정에서 손실이 되는 것을 허용할 것인지 설정
        
        // 2. Delete
        // Key Chain은 Key값에 중복이 생기면 저장할 수 없기때문에 먼저 Delete
        SecItemDelete(keyChainQuery)
        
        // 3. Create
        let status: OSStatus = SecItemAdd(keyChainQuery, nil)
    
        assert(status == noErr, "failed to saving Token")
    }
    
    // Read
    func read(account: accountType) -> String? {
        
        let KeyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceURL + account.rawValue,
            kSecAttrAccount: account.rawValue,
            kSecReturnData: kCFBooleanTrue as Any, // CFData타입으로 불러오라는 의미
            kSecMatchLimit: kSecMatchLimitOne // 중복되는 경우 하나의 값만 가져오라는 의미
        ]
        // CFData 타입 -> AnyObject로 받고, Data로 타입변환해서 사용하면됨
        
        // Read
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(KeyChainQuery, &dataTypeRef)
        
        // Read 성공 및 실패한 경우
        if(status == errSecSuccess) {
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else {
            print("failed to loading, status code = \(status)")
            return nil
        }
    }
}

