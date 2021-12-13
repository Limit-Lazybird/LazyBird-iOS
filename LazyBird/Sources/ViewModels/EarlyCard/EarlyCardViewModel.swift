//
//  EarlyCardViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/14.
//

import UIKit

class EarlyCardViewModel: NSObject {
    var cardCount: Observable<Int> = Observable(value: 0)
    var earlyCards: Observable<[EarlyCard]> = Observable(value: [EarlyCard]())
    
    let earlyCardManager = EarlyCardManager.shared // 캘린더 api manager
    
    /* 얼리카드 목록 호출 API */
    func requestEarlyCardList(){
        earlyCardManager.requestEarlyCardList { earlyCards in
            
            self.earlyCards.value.removeAll()
            self.earlyCards.value.append(contentsOf: earlyCards.earlyCardList.reversed())
        }
    }
    
    /* 얼리카드 목록 호출 개수API */
    func requestEarlyCardListForCount(){
        earlyCardManager.requestEarlyCardList { earlyCards in
            self.cardCount.value = earlyCards.earlyCardList.count
        }
    }
}
