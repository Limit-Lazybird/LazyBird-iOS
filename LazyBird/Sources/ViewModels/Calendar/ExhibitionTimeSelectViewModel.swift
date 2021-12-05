//
//  ExhibitionTimeSelectViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/05.
//

import UIKit

class ExhibitionTimeSelectViewModel {
    let ampm: [String] = ["오전", "오후"]
    let hour: [String] = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    let min: [String] = ["00","10","20","30","40","50"]
    let parsedHourDict: [String:String] = ["01":"13","02":"14",
                                           "03":"15","04":"16",
                                           "05":"17","06":"18",
                                           "07":"19","08":"20",
                                           "09":"21","10":"22",
                                           "11":"23","12":"00"]
    
    // 초기값 세팅
    var selectedAmpmTitle: String = "오전"
    var selectedHourTitle: String = "01"
    var selectedMinTitle: String = "00"
    
    func setSelectedAmpmTitle(ampm: String){
        self.selectedAmpmTitle = ampm
    }
    
    func setSelectedHourTitle(hour: String){
        self.selectedHourTitle = hour
    }
    
    func setSelectedMinTitle(min: String){
        self.selectedMinTitle = min
    }
    
    func getSelectedTime() -> String{
        switch selectedAmpmTitle{
        case "오전":
            return "\(selectedHourTitle) : \(selectedMinTitle)"
        case "오후":
            return "\(parsedHourDict[selectedHourTitle] ?? "") : \(selectedMinTitle)"
        default:
            return ""
        }
    }
}
