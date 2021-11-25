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
    var exhibits: Observable<[SearchedExhibit]> = Observable(value: [])
    
    func fetchSearchedExhibit(word: String){
        searchAPIManager.requestSearchedExhibitList(word: word) { searchedExhibits in
            self.exhibits.value.removeAll()
            self.exhibits.value.append(contentsOf: searchedExhibits.searchList)
        }
    }

    //getter
    func getExhibits() -> Observable<[SearchedExhibit]> {
        return self.exhibits
    }
}
