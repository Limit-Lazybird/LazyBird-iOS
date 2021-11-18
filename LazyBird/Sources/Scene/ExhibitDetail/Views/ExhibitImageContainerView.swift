//
//  ExhibitImageContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/10.
//

import UIKit
import SnapKit
import Then


class ExhibitImageContainerView: UIView {
    let exhibitImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    let earlybirdD_dayView = UIView().then{
        $0.backgroundColor = UIColor.Opacity.or0190
    }
    
    let earlybirdLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .MontBold, size: 13)
        $0.textColor = .white
    }
    
    let d_dayLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .MontBold, size: 13)
        $0.textColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(){
        exhibitImageView.image = UIImage(named: "test")
        earlybirdLabel.text = "Today's earlybird"
        d_dayLabel.text = "D - 10"
    }
    
    func setUI(){
        self.addSubview(exhibitImageView)
        self.addSubview(earlybirdD_dayView)
        earlybirdD_dayView.addSubview(earlybirdLabel)
        earlybirdD_dayView.addSubview(d_dayLabel)
        
        exhibitImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.height.equalTo(exhibitImageView.snp.width).multipliedBy(1.33333333333)
        }
        
        earlybirdD_dayView.snp.makeConstraints{
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        
        earlybirdLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(11.0)
        }
        
        d_dayLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-11.0)
        }
    }
}
