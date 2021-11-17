//
//  Exhibits.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/18.
//

import UIKit

struct Exhibits: Codable {
    let exhbtList: [Exhibit]
}

struct Exhibit: Codable {
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
    let dt_img: String?
    let excbt_url: String?
    let exhbt_notice: String?
    let eb_yn: String?
    let exhbt_type_cd: Int
}
