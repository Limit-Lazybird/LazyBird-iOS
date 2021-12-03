//
//  CalendarViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/02.
//

import UIKit

class CalendarViewModel {
    //TODO: 1. 현재 페이지 정보 담아놓자. Date 형식
    var currentPage: Observable<Date> = Observable(value: Date())
    let calendarManager = CalendarManager.shared // 캘린더 api manager
    
    var monthlySchedules: Observable<[Schedule]> = Observable(value: [Schedule]())
    var unregistedSchedules: Observable<[Schedule]> = Observable(value: [Schedule]()) //
    
    func setCurrentPage(currentPage: Date){
        self.currentPage.value = currentPage
    }
    
    /* 캘린더에 저장된 전시 예약 정보 (월별) Request */
    func requestSchedules(reser_dt: String){
        calendarManager.requestSchedules(reser_dt: reser_dt) { schedules in
            self.monthlySchedules.value.removeAll()
            self.monthlySchedules.value.append(contentsOf: schedules.calList)
        }
    }
    
    /* 예약이 된 전시지만 캘린더에 등록이 안된 리스트를 출력하는 API입니다. */
    func requestUnregistedSchedules(){
        calendarManager.requestUnregistedSchedules { schedules in
            self.unregistedSchedules.value.removeAll()
            self.unregistedSchedules.value.append(contentsOf: schedules.calList)
        }
    }
}
