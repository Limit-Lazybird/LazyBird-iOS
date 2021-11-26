//
//  SettingItemView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit
import SnapKit
import Then

class SettingItemView: UIView {
    //MARK: - Properties
    var delegate: SettingViewControllerProtocol?
    var setType: settingType?
    
    //MARK: - Properties
    let titleLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = .white
    }
    
    lazy var moreBtn = UIButton().then{
        $0.setImage(UIImage(named: "ic_expand_light"), for: .normal)
        $0.addTarget(self, action: #selector(moreBtnPressed(_:)), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.Background.darkGray02
        self.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(moveToDetail(_:))))
        
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    @objc func moveToDetail(_ sender: Any){
        guard let setType = setType else {
            print("moreBtnPressed type is nil")
            return
        }
        
        self.delegate?.moveToDetail(type: setType)
    }
    
    @objc func moreBtnPressed(_ sender: UIButton){
        guard let setType = setType else {
            print("moreBtnPressed type is nil")
            return
        }

        self.delegate?.moveToDetail(type: setType)
    }
    
    func config(text: String){
        titleLabel.text = text
    }
    
    func setUI(){
        self.addSubview(titleLabel)
        self.addSubview(moreBtn)
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16.0)
            $0.centerY.equalToSuperview()
        }
        
        moreBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.width.height.equalTo(24.0)
            $0.centerY.equalToSuperview()
        }
    }
}
