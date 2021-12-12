//
//  ExhibitionVisitRequest.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/12.
//

import UIKit

struct ExhibitionVisitRequest {
    let exhbt_cd: String
    let visit_yn: String
    var exhbt_type: String?
    var toDict: [String:String]
    
    init(exhbt_cd: String, visit_yn: String, exhbt_type: String?){
        self.exhbt_cd = exhbt_cd
        self.visit_yn = visit_yn
        self.exhbt_type = exhbt_type
        self.toDict = ["exhbt_cd":self.exhbt_cd,
                       "visit_yn":self.visit_yn,
                       "exhbt_type":self.exhbt_type ?? ""]
    }
    
    mutating func updateDict(token: String){
        self.toDict.updateValue(token, forKey: "token")
    }
}
