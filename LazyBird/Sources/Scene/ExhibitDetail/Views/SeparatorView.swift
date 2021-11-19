//
//  SeparaterView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/10.
//

import UIKit
import SnapKit
import Then


class SeparatorView: UIView {
    
    let separator = UIView().then{
        $0.backgroundColor = UIColor.Background.darkGray02
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(separator)
        separator.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(16.0)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
