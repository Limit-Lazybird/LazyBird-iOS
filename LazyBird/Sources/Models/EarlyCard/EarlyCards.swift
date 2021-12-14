//
//  EarlyCards.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/14.
//

import UIKit

struct EarlyCards: Codable {
    let earlyCardList: [EarlyCard]
}

struct EarlyCard: Codable{
    let exhbt_cd: String
    let exhbt_nm: String
    let exhbt_lct: String
    let early_rg_dt: String
    var reser_dt: String
    let exhbt_sn: String
    let early_num: Int
}
