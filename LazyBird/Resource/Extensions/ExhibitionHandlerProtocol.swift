//
//  ExhibitionHandlerProtocol.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/29.
//

import UIKit

protocol ExhibitionHandlerProtocol {
    var exhibitViewModel: ExhibitViewModel? { get set }
    var exhibitSearchViewModel: ExhibitSearchViewModel? { get set }
    var myBirdViewModel: MyBirdViewModel? { get set }
}

enum ExhibitViewType{
    case exhibit
    case exhibitSearch
    case mybird
}
