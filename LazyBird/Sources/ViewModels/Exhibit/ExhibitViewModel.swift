//
//  ExhibitViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/18.
//

import UIKit

protocol ExhibitViewModelProtocol {
    var exhibits: Observable<[Exhibit]> { get set } // 얼리버드 리스트
    func fetchExhibits() // server <-> client 통신,
}

class ExhibitViewModel: ExhibitViewModelProtocol {
    private let apiManager = APIManager.shared
    
    var exhibits: Observable<[Exhibit]> = Observable(value: [])
    
    func fetchExhibits() {
        
    }
    
    //getter
    func getExhibits() -> Observable<[Exhibit]> {
        return self.exhibits
    }
    

}
