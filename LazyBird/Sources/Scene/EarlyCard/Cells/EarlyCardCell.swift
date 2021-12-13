//
//  EarlyCardCell.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/14.
//

import UIKit

class EarlyCardCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "earlyCardCell"
    
    //MARK: - UI Components
    let cardBgView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 18.0
    }
    
    let thumbnailImageView = UIImageView().then{
        $0.contentMode = .top
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 18.0
    }
    
    let circleView = UIView().then{
        $0.backgroundColor = UIColor.Background.black02
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 30 / 2
    }
    
    let circleViewTwo = UIView().then{
        $0.backgroundColor = UIColor.Background.black02
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 30 / 2
    }
    
    let dashLineImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.image = UIImage(named: "dash_line")
    }
    
    let numberLabel = UILabel().then{
        $0.text = "NO.X"
        $0.font = UIFont.TTFont(type: .MontBold, size: 12)
        $0.textColor = UIColor.Point.or01
    }
    
    let exhibitTitleLabel = UILabel().then{
        $0.text = "aaasdad"
        $0.font = UIFont.TTFont(type: .SDBold, size: 12)
        $0.textColor = UIColor.Background.black02
    }
    
    let visitAlertLabel = UILabel().then{
        $0.text = "관람"
        $0.font = UIFont.TTFont(type: .SDBold, size: 12)
        $0.textColor = UIColor.Background.black02
    }
    
    let visitLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 12)
        $0.textColor = UIColor.Background.black02
    }
    
    //MARK: - Life Cycle
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20.0
        self.backgroundColor = .brown
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    //MARK: - Functions
    func config(card: EarlyCard, count: Int, newWidth: CGFloat){
        //TODO: number, title, date 바인딩하자
        self.numberLabel.text = "NO.\(count)"
        self.exhibitTitleLabel.text = card.exhbt_nm
        self.visitLabel.text = card.early_rg_dt
        
        thumbnailImageView.kf.setImage(with: URL(string: card.exhbt_sn)){ result in
            switch result{
            case .success:
                self.thumbnailImageView.image = self.thumbnailImageView.image?.resize(newWidth: newWidth)
            case .failure(let error):
                print("error -> \(error.localizedDescription)")
            }
        }
    }
    
    func setUI(){
        self.contentView.addSubview(cardBgView)
        cardBgView.addSubview(thumbnailImageView)
        cardBgView.addSubview(circleView)
        cardBgView.addSubview(circleViewTwo)
        cardBgView.addSubview(dashLineImageView)
        cardBgView.addSubview(numberLabel)
        cardBgView.addSubview(exhibitTitleLabel)
        cardBgView.addSubview(visitAlertLabel)
        cardBgView.addSubview(visitLabel)
        
        thumbnailImageView.snp.makeConstraints{
            $0.top.equalTo(cardBgView.snp.top).offset(11.0)
            $0.leading.equalTo(cardBgView.snp.leading).offset(11.0)
            $0.trailing.equalTo(cardBgView.snp.trailing).offset(-11.0)
            $0.bottom.equalTo(dashLineImageView.snp.top).offset(-36.0)
        }
        
        circleView.snp.makeConstraints{
            $0.centerY.equalTo(cardBgView.snp.centerY).multipliedBy(1.4)
            $0.centerX.equalTo(cardBgView.snp.leading).offset(-4.0)
            $0.width.height.equalTo(30.0)
        }
        
        circleViewTwo.snp.makeConstraints{
            $0.centerY.equalTo(cardBgView.snp.centerY).multipliedBy(1.4)
            $0.centerX.equalTo(cardBgView.snp.trailing).offset(4.0)
            $0.width.height.equalTo(30.0)
        }
        
        dashLineImageView.snp.makeConstraints{
            $0.centerY.equalTo(circleView.snp.centerY)
            $0.leading.equalTo(circleView.snp.trailing).offset(10.0)
            $0.trailing.equalTo(circleViewTwo.snp.leading).offset(-10.0)
            $0.height.equalTo(5.0)
        }
        
        numberLabel.snp.makeConstraints{
            $0.top.equalTo(dashLineImageView.snp.bottom).offset(10.0)
            $0.leading.equalTo(cardBgView.snp.leading).offset(21.0)
        }
        
        exhibitTitleLabel.snp.makeConstraints{
            $0.top.equalTo(numberLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(cardBgView.snp.leading).offset(21.0)
            $0.trailing.equalTo(cardBgView.snp.trailing).offset(-21.0)
        }
        
        visitAlertLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitTitleLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(cardBgView.snp.leading).offset(21.0)
        }
        
        visitLabel.snp.makeConstraints{
            $0.leading.equalTo(visitAlertLabel.snp.trailing).offset(4.0)
            $0.centerY.equalTo(visitAlertLabel.snp.centerY)
        }
        
        cardBgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
