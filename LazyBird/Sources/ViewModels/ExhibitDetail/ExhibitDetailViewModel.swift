//
//  ExhibitDetailViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/19.
//

import UIKit

protocol ExhibitDetailViewModelProtocol {
    var exhibit: Observable<Exhibit> { get set }
}

class ExhibitDetailViewModel: ExhibitDetailViewModelProtocol {
    var exhibit: Observable<Exhibit> = Observable(value: Exhibit())
    
    func getExhibit() -> Observable<Exhibit>{
        return self.exhibit
    }
    
    func setExhibit(_ exhibit: Exhibit){
        self.exhibit.value = exhibit
    }
}
