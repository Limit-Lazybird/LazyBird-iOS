//
//  NoticeView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/24.
//

import UIKit
import SnapKit
import Then

class NoticeView: UIView {
    let dotLabel = UILabel().then{
        $0.text = "•"
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = .white
    }
    
    let noticeLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.numberOfLines = 5
        $0.lineBreakMode = .byWordWrapping
        $0.textColor = .white
    }
    
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    func config(notice: String){
        self.noticeLabel.text = notice
    }
    
    func setUI(){
        self.addSubview(dotLabel)
        self.addSubview(noticeLabel)
        
        dotLabel.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
            $0.width.height.equalTo(10.0)
        }
        
        noticeLabel.snp.makeConstraints{
            $0.top.equalTo(dotLabel.snp.top)
            $0.leading.equalTo(dotLabel.snp.trailing).offset(4.0)
            $0.bottom.trailing.equalToSuperview()
        }
    }
}
