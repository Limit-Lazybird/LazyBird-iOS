//
//  EarlyBirdCell.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/27.
//

import UIKit
import SnapKit
import Then
import CollectionViewPagingLayout
import Kingfisher

class EarlyBirdCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier: String = "earlyBirdCell"
    static let height: CGFloat = 436.0
    
    //MARK: - UI Components
    let bgView = UIView().then{
        $0.layer.masksToBounds = true
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 10.0
    }
    
    let exhibitImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10.0
    }
    
    let topStickView = UIView().then{
        $0.backgroundColor = UIColor.Basic.black01
    }
    
    let titleLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.textColor = .white
    }
    
    let circleView = UIView().then{
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor.Point.or01
        $0.layer.cornerRadius = 50 / 2
    }
    
    let discountLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .MontBold, size: 21)
        $0.textColor = UIColor.Basic.black01
    }
    
    
    @objc func likeBtnPressed(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected{ // 눌렸을경우 빨간하트
            // TODO: 빨간하트로 전환
            print("test --> 빨간 하트로 전환 됨")
        }else{
            // TODO: 빈 하트로 전환
            print("test --> 빈 하트로 전환 됨")
        }
    }
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func config(exhibit: Exhibit){
        exhibitImageView.kf.setImage(with: URL(string: exhibit.exhbt_sn ?? ""))
        titleLabel.text = exhibit.exhbt_nm
        discountLabel.text = exhibit.dc_percent
    }
    
    func setUI(){
        self.contentView.addSubview(bgView)
        bgView.addSubview(exhibitImageView)
        bgView.addSubview(topStickView)
        bgView.addSubview(circleView)
        topStickView.addSubview(titleLabel)
        circleView.addSubview(discountLabel)
        
        bgView.snp.makeConstraints{
            $0.leading.equalTo(self.contentView.safeAreaLayoutGuide).offset(32.0)
            $0.trailing.equalTo(self.contentView.safeAreaLayoutGuide).offset(-32.0)
            $0.top.equalTo(self.contentView.safeAreaLayoutGuide).offset(24.0)
            $0.bottom.equalTo(self.contentView.safeAreaLayoutGuide).offset(-24.0)
        }
        
        exhibitImageView.snp.makeConstraints{
            $0.edges.equalTo(bgView.safeAreaLayoutGuide)
        }
        
        topStickView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(bgView.safeAreaLayoutGuide)
            $0.height.equalTo(40.0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerY.equalTo(topStickView.safeAreaLayoutGuide)
            $0.leading.equalTo(topStickView.snp.leading).offset(8.0)
            $0.trailing.equalTo(topStickView.snp.trailing).offset(-8.0)
        }
        
        circleView.snp.makeConstraints{
            $0.top.equalTo(bgView.snp.top).offset(15.0)
            $0.trailing.equalTo(bgView.snp.trailing).offset(-16.0)
            $0.width.height.equalTo(50.0)
        }
        
        discountLabel.snp.makeConstraints{
            $0.centerX.centerY.equalTo(circleView.safeAreaLayoutGuide)
        }
    }
}

//MARK: - Extension

extension EarlyBirdCell: StackTransformView {
    var stackOptions: StackTransformViewOptions {
        .init(scaleFactor: 0.2,
              minScale: 0.2,
              maxStackSize: 20,
              spacingFactor: 0.1,
              alphaFactor: 0.5,
              perspectiveRatio: 0.3,
              shadowEnabled: true,
              shadowRadius: 5,
              popAngle: 0,
              popOffsetRatio: .init(width: -1.45, height: 0),
              stackPosition: CGPoint(x: 1, y: 0)
        )
    }
}


