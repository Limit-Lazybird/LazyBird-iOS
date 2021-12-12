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
    
    var monthlySchedules: Observable<[Schedule]> = Observable(value: [Schedule]()) // 캘린더에 저장된 전시 예약 정보(스케쥴)
    var dummyMonthlySchedules: Observable<[Schedule]> = Observable(value: [Schedule]())
    
    var unregistedSchedules: Observable<[Schedule]> = Observable(value: [Schedule]()) //예약이 된 전시지만 캘린더에 등록이 안된 전시
    
    var events: Observable<[Date]> = Observable(value: [Date]())
    
    lazy var dateFormatter: DateFormatter = DateFormatter().then{
        $0.locale = Locale(identifier: "ko_KR")
        $0.dateFormat = "yyyyMMdd"
    }
    
    func setCurrentPage(currentPage: Date){
        self.currentPage.value = currentPage
    }
    
    
    /* 1. 캘린더에 저장된 전시 예약 정보 (월별) Request */
    /* 2. 개인 전시 일정 리스트 (월별) Request */
    func requestMonthlySchedules(reser_dt: String){
        let replaceReser_dt = reser_dt.replacingOccurrences(of: "-", with: "")
        
        //TODO: 캘린더 + 커스텀 일정 불러와서 하나로 합치고 -> 그 뒤에 정렬해서 뿌려주자
        calendarManager.requestSchedules(reser_dt: replaceReser_dt) { schedules in
            self.dummyMonthlySchedules.value.removeAll()
            
            let changedSchedules = self.getChangedSchedules(schedules: schedules , isCustom: false)
            
            self.dummyMonthlySchedules.value.append(contentsOf: changedSchedules.calList)
            self.calendarManager.requestCustomSchedules(reser_dt: replaceReser_dt) { schedules in
                let changedSchedules = self.getChangedSchedules(schedules: schedules, isCustom: true)
                
                self.dummyMonthlySchedules.value.append(contentsOf: changedSchedules.calList)
                //TODO: monthlySchedules 의 아이템들을 날짜순으로 정렬
                self.monthlySchedules.value = self.dummyMonthlySchedules.value.sorted(by: {
                    self.strToDate(str: $0.reser_dt)! < self.strToDate(str: $1.reser_dt)!
                })
                //TODO: 스케쥴이 등록된 일자에 이벤트 등록하기
                self.events.value = self.monthlySchedules.value.map{
                    self.strToDate(str: $0.reser_dt) ?? Date()
                }
            }
        } // item 변경 끝.
    }
    
    /* 예약이 된 전시지만 캘린더에 등록이 안된 리스트를 출력하는 API입니다. */
    func requestUnregistedSchedules(){
        calendarManager.requestUnregistedSchedules { schedules in
            self.unregistedSchedules.value.removeAll()
            self.unregistedSchedules.value.append(contentsOf: schedules.calList)
        }
    }
    
    /* 전시회 방문, 방문취소 API */
    func requestExhibitionVisit(exhibitionVisit: ExhibitionVisitRequest, completion: @escaping ()->(Void)){
        calendarManager.requestExhibitionVisit(exhibitionVisit: exhibitionVisit){
            completion()
        }
    }
    
    
    /* 요일 return */
    func getDayOfTheWeek(date: String) -> String{
        guard let date = strToDate(str: date) else {
            print("CalendarViewModel getDayOfTheWeek date is nil")
            return ""
        }
        
        let parseDict: [String:String] = ["월":"Mon","화":"Tue",
                                          "수":"Wed","목":"Thu",
                                          "금":"Fri","토":"Sat",
                                          "일":"Sun"]
        
        let formatter = DateFormatter().then{
            $0.locale = Locale(identifier: "ko_KR")
            $0.dateFormat = "E"
        }
        
        return parseDict[formatter.string(from: date)] ?? "Nil"
    }
    
    /* 일(number) return */
    func getDayOfTheWeekNum(date: String) -> String{
        guard let date = strToDate(str: date) else {
            print("CalendarViewModel getDayOfTheWeekNum date is nil")
            return ""
        }
        
        let formatter = DateFormatter().then{
            $0.locale = Locale(identifier: "ko_KR")
            $0.dateFormat = "dd"
        }
        
        return formatter.string(from: date)
    }
    
    private func strToDate(str: String) -> Date?{
        let dateFormatter = DateFormatter().then{
            $0.locale = Locale(identifier: "ko_KR")
            $0.dateFormat = "yyyyMMdd"
        }
        return dateFormatter.date(from: str)
    }
    
    private func getChangedSchedules(schedules: Schedules, isCustom: Bool) -> Schedules{
        var dummyList = schedules
        
        for index in 0..<dummyList.calList.count{
            dummyList.calList[index].setIsCustom(isCustom: isCustom)
        }
        
        return dummyList
    }
}
