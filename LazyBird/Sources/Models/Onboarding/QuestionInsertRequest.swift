//
//  QuestionInsertRequest.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit

struct QuestionInsertRequest {
    let token: String
    let answer_idx: String
    
    init(token: String, answer_idx: String){
        self.token = token
        self.answer_idx = answer_idx
    }
    
    var toDictionary: [String: String] {
        let dict: [String: String] = ["token": self.token,
                                      "answer_idx": self.answer_idx]
        return dict
    }
}
