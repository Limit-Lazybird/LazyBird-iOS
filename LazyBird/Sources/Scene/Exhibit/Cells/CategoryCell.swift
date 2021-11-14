//
//  CategoryCell.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/27.
//

import UIKit
import SnapKit
import Then


class CategoryCell: UICollectionViewCell {
    static let identifier: String = "categoryCell"
    static let height: CGFloat = 26.0
    
    lazy var categoryLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 13.0)
        $0.textColor = UIColor.Basic.gray05
    }
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.Background.darkGray01
        self.layer.masksToBounds = true
        self.layer.cornerRadius = frame.height / 2
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func config(category: String){
        self.categoryLabel.text = category
    }
    
    func setUI(){
        self.contentView.addSubview(categoryLabel)

        categoryLabel.snp.makeConstraints{
            $0.leading.equalTo(self.contentView.safeAreaLayoutGuide).offset(12.0)
            $0.trailing.equalTo(self.contentView.safeAreaLayoutGuide).inset(12.0)
            $0.top.equalTo(self.contentView.safeAreaLayoutGuide).offset(6.0)
            $0.bottom.equalTo(self.contentView.safeAreaLayoutGuide).inset(4.0)
        }
    }
    
    static func fittingSize(availableHeight: CGFloat, name: String) -> CGSize {
        let cell = CategoryCell()
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        
        cell.config(category: name)
        
        return cell.contentView.systemLayoutSizeFitting(targetSize,
                                                        withHorizontalFittingPriority: .fittingSizeLevel,
                                                        verticalFittingPriority: .required)
    }
}
