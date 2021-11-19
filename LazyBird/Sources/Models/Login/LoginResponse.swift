//
//  LoginResponse.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/19.
//

import UIKit

struct LoginResponse: Codable {
    let jwt: Jwt
    let useYN: String
}

struct Jwt: Codable{
    let code: Int
    let msg: String
    let token: String
}
