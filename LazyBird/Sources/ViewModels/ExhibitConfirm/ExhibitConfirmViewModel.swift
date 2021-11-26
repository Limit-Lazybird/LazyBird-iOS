//
//  ExhibitConfirmViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit

class ExhibitConfirmViewModel {
    let reservedAPIManager = ReservedAPIManager.shared
    
    func requestReserve(exhbt_cd: String){
        reservedAPIManager.requestReserved(exhbt_cd: exhbt_cd, state_cd: "20")
    }
}
