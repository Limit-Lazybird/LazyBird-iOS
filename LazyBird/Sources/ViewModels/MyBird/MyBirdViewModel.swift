//
//  MyBirdViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit

class MyBirdViewModel {
    let apiManager = MyBirdAPIManager.shared
    let userInfoManager = UserInfoAPIManager.shared
    
    var favoriteExhibits: Observable<[Exhibit]> = Observable(value: [])
    var reservationExhibits: Observable<[Exhibit]> = Observable(value: [])
    
    var userInfo: Observable<UserInfo> = Observable(value: UserInfo())
    
    
    func requestFavoriteExhibits(){
        apiManager.requestFavoriteExhibitList { exhibits in
            //TODO: favorite exhibits update
            print("fa exhibits ----> \(exhibits)")
            self.favoriteExhibits.value.removeAll()
            self.favoriteExhibits.value.append(contentsOf: exhibits.exhbtList)
        }
    }
    
    func requestReservationExhibits(){
        apiManager.requestReservationExhibits { exhibits in
            //TODO: reservation exhibits update
            print("re exhibits ----> \(exhibits)")
            self.reservationExhibits.value.removeAll()
            self.reservationExhibits.value.append(contentsOf: exhibits.exhbtList)
        }
    }
    
    func requestUserInfo(){
        userInfoManager.requestUserInfo { userInfo in
            self.userInfo.value = userInfo
        }
    }
}
