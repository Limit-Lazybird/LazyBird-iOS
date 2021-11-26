//
//  UserInfo.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit

struct UserInfo: Codable {
    let user_email: String?
    let user_nm: String?
    let comp_cd: String?
    
    init(){
        user_email = nil
        user_nm = nil
        comp_cd = nil
    }
}
