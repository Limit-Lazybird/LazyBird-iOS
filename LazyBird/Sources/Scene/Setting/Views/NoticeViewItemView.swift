//
//  NoticeViewItemView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit

class NoticeViewItemView: UIView {
    var delegate: NoticeViewControllerProtocol?
    
    let titleLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = .white
    }
    
    let secLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDReg, size: 11)
        $0.textColor = .white
    }
    lazy var moreBtn = UIButton().then{
        $0.setImage(UIImage(named: "ic_expand_down_light"), for: .normal)
        $0.setImage(UIImage(named: "ic_expand_up_light"), for: .selected)
        $0.addTarget(self, action: #selector(moreBtnPressed(_:)), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.Background.black02
        self.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(moveToDetail(_:))))
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Functions
    @objc func moveToDetail(_ sender: Any){
        moreBtn.isSelected = !moreBtn.isSelected
        self.delegate?.expandNotice(isSelected: !moreBtn.isSelected)
    }
    
    @objc func moreBtnPressed(_ sender: UIButton){
        moreBtn.isSelected = !moreBtn.isSelected
        self.delegate?.expandNotice(isSelected: !moreBtn.isSelected)
    }
    
    func config(secText: String, titleText: String){
        self.secLabel.text = secText
        self.titleLabel.text = titleText
    }
    
    func setUI(){
        self.addSubview(titleLabel)
        self.addSubview(secLabel)
        self.addSubview(moreBtn)
        
        secLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(8.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(secLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(secLabel.snp.leading)
        }
        
        moreBtn.snp.makeConstraints{
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.width.height.equalTo(24.0)
        }
    }
}
