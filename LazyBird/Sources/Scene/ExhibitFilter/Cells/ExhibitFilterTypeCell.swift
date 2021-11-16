//
//  ExhibitFilterTypeCell.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/16.
//

import UIKit
import SnapKit
import Then

class ExhibitFilterTypeCell: UICollectionViewCell {
    //MARK: - Properties
    
    static let identifier = "exhibitFilterTypeCell"
    static let height: CGFloat = 26.0
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
                print("셀 선택 됨")
                typeLabel.textColor = UIColor.Basic.gray02
                self.contentView.backgroundColor = .white
            }
            else {
                print("셀 선택 해제 됨")
                typeLabel.textColor = UIColor.Basic.gray05
                self.contentView.backgroundColor = UIColor.Background.darkGray01
            }
        }
    }
    
    //MARK: - UI Components
    
    lazy var typeLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.textColor = .white
    }
    
    //MARK: - Life Cycle
    
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
    
    //MARK: - Functions
    
    func config(type: String){
        self.typeLabel.text = type
    }
    
    func setUI(){
        self.contentView.addSubview(typeLabel)
        
        typeLabel.snp.makeConstraints{
            $0.leading.equalTo(self.contentView.safeAreaLayoutGuide).offset(12.0)
            $0.trailing.equalTo(self.contentView.safeAreaLayoutGuide).inset(12.0)
            $0.top.equalTo(self.contentView.safeAreaLayoutGuide).offset(6.0)
            $0.bottom.equalTo(self.contentView.safeAreaLayoutGuide).inset(4.0)
        }
    }
    
    static func fittingSize(availableHeight: CGFloat, name: String) -> CGSize {
        let cell = ExhibitFilterTypeCell()
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        
        cell.config(type: name)
        
        return cell.contentView.systemLayoutSizeFitting(targetSize,
                                                        withHorizontalFittingPriority: .fittingSizeLevel,
                                                        verticalFittingPriority: .required)
    }
}
