//
//  ExhibitionDateSelectViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/05.
//

import UIKit

class ExhibitionDateSelectViewModel {
    var currentPage: Observable<Date> = Observable(value: Date())
    var selectedDate: String = ""
    
    func setCurrentPage(currentPage: Date){
        self.currentPage.value = currentPage
    }
    
    func setSelectedDate(_ date: String){
        self.selectedDate = date
    }
}
