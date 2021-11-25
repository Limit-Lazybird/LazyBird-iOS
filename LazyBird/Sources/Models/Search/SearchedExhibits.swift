//
//  SearchedExhibits.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit

struct SearchedExhibits: Codable {
    let searchList: [SearchedExhibit]
}

struct SearchedExhibit: Codable {
    let exhbt_cd: String?
    let exhbt_nm: String?
    let exhbt_sub_nm: String?
    let exhbt_sn: String?
    let exhbt_lct: String?
    let exhbt_from_dt: String?
    let exhbt_to_dt: String?
    let exhbt_age: String?
    let exhbt_prc: String?
    let dc_percent: String?
    let dc_prc: String?
    let exhbt_expnt: String?
    let eb_yn: String?
    let exhbt_type_cd: Int
    let exhbt_type_cd_sub: String?
    
    init(){
        exhbt_cd = nil
        exhbt_nm = nil
        exhbt_sub_nm = nil
        exhbt_sn = nil
        exhbt_lct = nil
        exhbt_from_dt = nil
        exhbt_to_dt = nil
        exhbt_age = nil
        exhbt_prc = nil
        dc_percent = nil
        dc_prc = nil
        exhbt_expnt = nil
        eb_yn = nil
        exhbt_type_cd = 0
        exhbt_type_cd_sub = nil
    }
}
