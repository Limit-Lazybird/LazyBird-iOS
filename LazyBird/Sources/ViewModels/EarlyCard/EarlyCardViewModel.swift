//
//  EarlyCardViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/14.
//

import UIKit

class EarlyCardViewModel: NSObject {
    var cardCount: Observable<Int> = Observable(value: 0)
    let earlyCardManager = EarlyCardManager.shared // 캘린더 api manager
    
    /* 얼리카드 목록 호출 API */
    func requestEarlyCardListForCount(){
        earlyCardManager.requestEarlyCardList { earlyCards in
            self.cardCount.value = earlyCards.earlyCardList.count
        }
    }
}
