//
//  ExhibitSearchViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit

protocol ExhibitSearchViewModelProtocol{
//    var exhibits: Observable<[Exhibit]> { get set } // 얼리버드 리스트
//    func fetchExhibits() // server <-> client 통신,
}

class ExhibitSearchViewModel {
    private let searchAPIManager = SearchAPIManager.shared
    var exhibits: Observable<[Exhibit]> = Observable(value: [])
    var fluidExhibits: [Exhibit] = [Exhibit]()
    
    func fetchSearchedExhibit(word: String){
        searchAPIManager.requestSearchedExhibitList(word: word) { exhibits in
            self.exhibits.value.removeAll()
            self.exhibits.value.append(contentsOf: exhibits.exhbtList)
        }
    }

    //getter
    func getExhibits() -> Observable<[Exhibit]> {
        return self.exhibits
    }
}
