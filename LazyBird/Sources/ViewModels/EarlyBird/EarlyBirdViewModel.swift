//
//  EarlyBirdViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/18.
//

import UIKit

/*
 얼리버드 리스트 정보
 
 TODO: model 정보 get만 하면 될듯
 
 */

protocol EarlyBirdViewModelProtocol {
    var earlyBirds: Observable<[Exhibit]> { get set } // 얼리버드 리스트
    func fetchEarlyBirds() // server <-> client 통신,
}

class EarlyBirdViewModel: EarlyBirdViewModelProtocol {
    private let apiManager = APIManager.shared
    
    var earlyBirds: Observable<[Exhibit]> = Observable(value: [])
    
    // getter
    func getEarlyBirds() -> Observable<[Exhibit]> {
        return self.earlyBirds
    }
    func fetchEarlyBirds(){
        apiManager.requestEarlyBirdList { exhibits in
            self.earlyBirds.value.append(contentsOf: exhibits.exhbtList)
        }
    }
    
    init(){ }
}
