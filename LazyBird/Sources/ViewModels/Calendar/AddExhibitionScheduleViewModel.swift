//
//  AddExhibitionScheduleViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/05.
//

import UIKit

class AddExhibitionScheduleViewModel {
    let calendarManager = CalendarManager.shared // 캘린더 api manager
    var currentExhibition: Schedule? // 캘린더에 추가할 현재 exhibition 정보

    /* 직접 등록하는 일정 전시 캘린더에 등록 */
    func requestSaveCustomSchedule(customSchedule: CustomInfoSaveRequest, completion: @escaping ()->(Void)){
        calendarManager.requestSaveCustomSchedule(customSchedule: customSchedule){
            completion()
        }
    }
    
    /* 예약한 전시 캘린더에 등록 */
    func requestSaveBookedSchedule(bookedSchedule: BookedInfoSaveRequest, completion: @escaping ()->(Void)){
        calendarManager.requestSaveBookedSchedule(bookedSchedule: bookedSchedule){
            completion()
        }
    }
    
    func requestCustomScheduleEdit(customEdit: ExhibitionCustomEditRequest, completion: @escaping ()->(Void)){
        calendarManager.requestCustomScheduleEdit(customEdit: customEdit) {
            print("수정 완료")
            completion()
        }
    }
    
    
    func setCurrentExhibition(exhibition: Schedule){
        self.currentExhibition = exhibition
    }
}
