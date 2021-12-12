//
//  Schedules.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/03.
//

import UIKit

struct Schedules: Codable {
    let calList: [Schedule]
}

struct Schedule: Codable{
    let exhbt_cd: String
    let exhbt_nm: String
    let exhbt_lct: String
    let reser_dt: String
    let start_time: String
    let end_time: String
    var visit_yn: String // 방문 여부 바꿀거임.
    var isCustom: Bool?
    
    mutating func updateVisitState(){
        if visit_yn == "Y"{
            self.visit_yn = "N"
        }else{
            self.visit_yn = "Y"
        }
    }
    
    mutating func setIsCustom(isCustom: Bool){
        self.isCustom = isCustom
    }
}
