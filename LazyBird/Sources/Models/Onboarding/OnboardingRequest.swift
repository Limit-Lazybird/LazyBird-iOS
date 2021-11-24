//
//  OnboardingRequest.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit

struct OnboardingRequest {
    let comp_cd: String
    let email: String
    let token: String
    let name: String
    
    init(comp_cd: String, email: String, token: String, name: String){
        self.comp_cd = comp_cd
        self.email = email
        self.token = token
        self.name = name
    }
    
    var toDictionary: [String: String] {
        let dict: [String: String] = ["comp_cd": self.comp_cd,
                                      "email": self.email,
                                      "token": self.token,
                                      "name": self.name]
        return dict
    }
}
