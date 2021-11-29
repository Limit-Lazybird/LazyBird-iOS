//
//  VariousExhibitionManagers.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/28.
//

import UIKit

/*
 Exhibit View에서 이용될 전시 리스트 정보들의 변경값들을 임시로 저장할 singleton 객체
 */

class VariousExhibitionManagers{
    static let shared = VariousExhibitionManagers()
    private init(){}
    
    var fluidExhibits: [Exhibit] = [Exhibit]()
    
    func updateFluidExhibits(index: Int){
        //TODO: 값 변경
//        self.fluidExhibits[index].like_yn =
    }
}
