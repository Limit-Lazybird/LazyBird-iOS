//
//  CustomInfoSaveRequest.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/05.
//

import UIKit

struct CustomInfoSaveRequest {
    let exhbt_nm: String
    let exhbt_lct: String
    let reser_dt: String
    let start_time: String
    let end_time: String
    var toDict: [String:String]
    
    init(exhbt_nm: String, exhbt_lct: String, reser_dt: String, start_time: String, end_time: String){
        self.exhbt_nm = exhbt_nm
        self.exhbt_lct = exhbt_lct
        self.reser_dt = reser_dt
        self.start_time = start_time
        self.end_time = end_time
        self.toDict = ["exhbt_nm":self.exhbt_nm,
                       "exhbt_lct":self.exhbt_lct,
                       "reser_dt":self.reser_dt,
                       "start_time":self.start_time,
                       "end_time":self.end_time]
    }
    
    mutating func updateDict(token: String){
        self.toDict.updateValue(token, forKey: "token")
    }
    
    
}
