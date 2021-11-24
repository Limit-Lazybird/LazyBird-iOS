//
//  AnalysisQuestions.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit

struct AnalysisQuestions: Codable {
    let questions: [AnalysisQuestion]
    
    enum CodingKeys: String, CodingKey {
        case questions = "customList"
    }
}

struct AnalysisQuestion: Codable {
    let cq_index: Int
    let cq_head: String
    let cs_index: Int
    let cs_head: String
}
