//
//  AddExhibitionScheduleViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/05.
//

import UIKit

class AddExhibitionScheduleViewModel {
    let calendarManager = CalendarManager.shared // 캘린더 api manager
    
    /* 직접 등록하는 일정 전시 캘린더에 등록 */
    func requestSaveCustomSchedule(customSchedule: CustomInfoSaveRequest){
        calendarManager.requestSaveCustomSchedule(customSchedule: customSchedule)
    }
}
