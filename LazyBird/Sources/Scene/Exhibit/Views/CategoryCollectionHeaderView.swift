//
//  CategoryCollectionHeaderView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/15.
//

import UIKit
import SnapKit
import Then

class CategoryCollectionHeaderView: UICollectionReusableView {
    
    static let identifier = "categoryCollectionHeaderView"
    static let height = 26.0
    
    let headerImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "filter")
    }
    
    func setupViews(){
        self.backgroundColor = UIColor.Background.darkGray01
        self.layer.cornerRadius = 26 / 2
        
        self.addSubview(headerImageView)

        headerImageView.snp.makeConstraints{
            $0.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
            $0.width.height.equalTo(24.0)
        }
    }
}
