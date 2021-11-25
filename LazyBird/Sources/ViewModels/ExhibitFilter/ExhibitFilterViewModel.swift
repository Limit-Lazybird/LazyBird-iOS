//
//  ExhibitFilterViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/24.
//

import UIKit

class ExhibitFilterViewModel {
    //TODO: 1. 전시 분류 / 2. 전시 부가 정보 / 3. 지역  정보 저장할 list 가지고있자
    let exhibitFilterManager = ExhibitFilterAPIManager.shared
    
    var classification: Set<String> = Set<String>()
    var additionalInformation: Set<String> = Set<String>()
    var region: Set<String> = Set<String>()
    var selectedCategory: [String] = [String]() // 마지막에 종합할거
    let classificationDict: [String: String] = ["0": "1",
                                                    "1": "2",
                                                    "2": "3",
                                                    "3": "4",
                                                    "4": "5",
                                                    "5": "6",]
    let additionalInformationDict: [String: String] = ["0": "401",
                                                       "1": "402",
                                                       "2": "403",
                                                       "3": "404",
                                                       "4": "405",
                                                       "5": "406",
                                                       "6": "407"]
    let regionDict: [String: String] = ["0": "301",
                                        "1": "302",
                                        "2": "303",
                                        "3": "304",
                                        "4": "305",
                                        "5": "306",
                                        "6": "307",
                                        "7": "308"]
    
    func addClassification(_ category: String){
        guard let category = classificationDict[category] else {
            print("잘못된 dict key 값입니다.")
            return
        }

        self.classification.insert(category)
    }
    func addAdditionalInformation(_ category: String){
        guard let category = additionalInformationDict[category] else {
            print("잘못된 dict key 값입니다.")
            return
        }
        self.additionalInformation.insert(category)
    }
    func addRegion(_ category: String){
        guard let category = regionDict[category] else {
            print("잘못된 dict key 값입니다.")
            return
        }
        
        self.region.insert(category)
    }
    
    func requestExhibitDTL(){
        selectedCategory.append(contentsOf: self.classification)
        selectedCategory.append(contentsOf: self.additionalInformation)
        selectedCategory.append(contentsOf: self.region)
        
        exhibitFilterManager.requestExhibitDTL(searchList: selectedCategory.joined(separator: ","))
    }
}
