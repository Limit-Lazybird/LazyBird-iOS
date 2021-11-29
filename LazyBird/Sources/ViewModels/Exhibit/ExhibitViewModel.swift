//
//  ExhibitViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/18.
//

import UIKit

protocol ExhibitViewModelProtocol{
    var exhibits: Observable<[Exhibit]> { get set } // 얼리버드 리스트
    var fluidExhibits: [Exhibit] { get set }
    func fetchExhibits() // server <-> client 통신,
}

class ExhibitViewModel: ExhibitViewModelProtocol {
    private let exhibitManager = ExhibitAPIManager.shared
    private let likeManager = LikeAPIManager.shared
    let exhibitFilterManager = ExhibitFilterAPIManager.shared
    var fluidExhibits: [Exhibit] = [Exhibit]()
//    let variousExhibitionManager = VariousExhibitionManagers.shared
    
    var exhibits: Observable<[Exhibit]> = Observable(value: [])
    
    func fetchExhibits() {
        exhibitManager.requestExhibitList { exhibits in
            self.exhibits.value.removeAll()
            self.fluidExhibits.removeAll()
            self.fluidExhibits.append(contentsOf: exhibits.exhbtList)
            self.exhibits.value.append(contentsOf: exhibits.exhbtList)
        }
    }
    
    func fetchCustomExhibits() {
        exhibitManager.requestCustomExhibitList { exhibits in
            self.exhibits.value.removeAll()
            self.fluidExhibits.removeAll()
            self.fluidExhibits.append(contentsOf: exhibits.exhbtList)
            self.exhibits.value.append(contentsOf: exhibits.exhbtList)
        }
    }
    
    func updateFilteredExhibits(exhibits: Exhibits){
        self.exhibits.value.removeAll()
        self.fluidExhibits.removeAll()
        self.fluidExhibits.append(contentsOf: exhibits.exhbtList)
        self.exhibits.value.append(contentsOf: exhibits.exhbtList)
    }
    
    func requestLike(exhbt_cd: String, like_yn: String){
        likeManager.requestLike(exhbt_cd: exhbt_cd, like_yn: like_yn)
    }
    
    func requestCategoryFilteredExhibits(category: String){
        exhibitFilterManager.requestExhibitDTL(searchList: category) { exhibits in
            print("카테고리 필터링 --> \(exhibits)")
            self.exhibits.value.removeAll()
            self.fluidExhibits.removeAll()
            self.fluidExhibits.append(contentsOf: exhibits.exhbtList)
            self.exhibits.value.append(contentsOf: exhibits.exhbtList)
        }
    }
    
    //getter
    func getExhibits() -> Observable<[Exhibit]> {
        return self.exhibits
    }
}
