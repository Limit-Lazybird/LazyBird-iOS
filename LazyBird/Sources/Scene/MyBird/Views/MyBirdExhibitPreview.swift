//
//  MyBirdExhibitPreview.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class MyBirdExhibitPreview: UIView {
    //MARK: - Properties
    
    //MARK: - UI Components
    let exhibitImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    let exhibitTitleLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 11)
        $0.numberOfLines = 0
        $0.textColor = .white
    }
    
    let dateLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDReg, size: 11)
        $0.textColor = .white
    }
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
//        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Functions
    func config(exhibit: Exhibit?){
        //TODO: 바인딩하자
        if let exhibit = exhibit {
            self.exhibitImageView.kf.setImage(with: URL(string: exhibit.exhbt_sn ?? ""))
            self.exhibitTitleLabel.text = exhibit.exhbt_nm
            self.dateLabel.text = "\(exhibit.exhbt_from_dt ?? "") ~ \(exhibit.exhbt_to_dt ?? "")"
        }else{
            self.exhibitImageView.image = nil
            self.exhibitTitleLabel.text = ""
            self.dateLabel.text = ""
        }
        
        
    }
    
    func setUI(){
        self.addSubview(exhibitImageView)
        self.addSubview(exhibitTitleLabel)
        self.addSubview(dateLabel)
        
        exhibitImageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(exhibitImageView.snp.width).multipliedBy(1.33076923077)
            
        }
        
        exhibitTitleLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitImageView.snp.bottom).offset(13.0)
            $0.leading.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitTitleLabel.snp.bottom).offset(4.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-4.0)
        }
    }
}
