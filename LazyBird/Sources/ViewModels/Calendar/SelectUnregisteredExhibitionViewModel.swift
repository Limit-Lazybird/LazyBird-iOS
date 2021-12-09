//
//  SelectUnregisteredExhibitionViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/06.
//

import UIKit

class SelectUnregisteredExhibitionViewModel {
    var unregistedSchedules: Observable<[Schedule]> = Observable(value: [Schedule]()) //예약이 된 전시지만 캘린더에 등록이 안된 전시
    var selectedTitle: String = ""
    
    func setUnregistedSchedules(schedule: [Schedule]){
        self.unregistedSchedules.value.append(contentsOf: schedule)
    }
    
    func setSelectedTitle(title: String){
        self.selectedTitle = title
    }
    
    func getUnregistedScheduleTitles() -> [String]{
        return self.unregistedSchedules.value.map{ $0.exhbt_nm }
    }
    
    func getSelectedExhibition() -> Schedule? {
        if selectedTitle == "" {
            return self.unregistedSchedules.value[0]
        }
        
        let selectedExhibition = self.unregistedSchedules.value.filter { $0.exhbt_nm == self.selectedTitle }
        
        if selectedExhibition.count == 0{
            return nil
        }
        return selectedExhibition.first
    }
}
