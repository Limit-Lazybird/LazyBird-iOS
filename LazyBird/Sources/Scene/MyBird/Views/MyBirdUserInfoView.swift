//
//  MyBirdUserInfoView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit
import SnapKit
import Then

class MyBirdUserInfoView: UIView {
    var viewModel: MyBirdViewModel?
    
    //MARK: - UI Components
    let nameTitleLabel = UILabel().then{
        $0.text = "name"
        $0.font = UIFont.TTFont(type: .MontBold, size: 12)
        $0.textColor = UIColor.Point.or01
    }
    
    let nameLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.textColor = .white
    }
    
    let emailTitleLabel = UILabel().then{
        $0.text = "email"
        $0.font = UIFont.TTFont(type: .MontBold, size: 12)
        $0.textColor = UIColor.Point.or01
    }
    
    let emailLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .MontReg, size: 13)
        $0.textColor = .white
    }
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.Background.darkGray02
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Functions
    func config(viewModel: MyBirdViewModel){
        //TODO: 유저 정보 받아와서 바인딩하자 일단은 더미     
        self.nameLabel.text = viewModel.userInfo.value.user_nm
        self.emailLabel.text = viewModel.userInfo.value.user_email
    }
    
    func setUI(){
        self.addSubview(nameTitleLabel)
        self.addSubview(nameLabel)
        self.addSubview(emailTitleLabel)
        self.addSubview(emailLabel)
        
        nameTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(11.0)
            $0.leading.equalToSuperview().offset(8.0)
        }
        
        nameLabel.snp.makeConstraints{
            $0.top.equalTo(nameTitleLabel.snp.top)
            $0.leading.equalTo(nameTitleLabel.snp.trailing).offset(22.0)
        }
        
        emailTitleLabel.snp.makeConstraints{
            $0.top.equalTo(nameTitleLabel.snp.bottom).offset(10.0)
            $0.leading.equalToSuperview().offset(8.0)
        }
        
        emailLabel.snp.makeConstraints{
            $0.top.equalTo(emailTitleLabel.snp.top)
            $0.leading.equalTo(emailTitleLabel.snp.trailing).offset(22.0)
            $0.bottom.equalToSuperview().offset(-12.0)
        }
    }
}
