//
//  LoginResponse.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/19.
//

import UIKit

struct LoginResponse: Codable {
    let jwt: Jwt  // token
    let refreshToken: String //  refreshToken
    let code: Int // status code
    let useYN: String // Y이면 성향분석 되어있음 ,  N이면 성향분석 안되있음
    let msg: String //  success Message
}

struct Jwt: Codable{
    let code: Int
    let msg: String
    let token: String
}
