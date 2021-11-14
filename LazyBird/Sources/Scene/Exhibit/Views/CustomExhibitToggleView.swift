//
//  CustomExhibitToggleView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/15.
//

import UIKit
import SnapKit
import Then

class CustomExhibitToggleView: UIView {
    
    //MARK: - UI Components
    
    let explainLabel = UILabel().then{
        $0.text = "나를 위한 맞춤 전시회만 보기"
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
    }
    
    lazy var controlSwitch = UISwitch().then{
        $0.isOn = false
        $0.onTintColor = UIColor.Point.or01 // 켜짐상태일때 색 지정
        $0.transform = CGAffineTransform(scaleX: 0.75, y: 0.75) // 크기 조정 (비율로 조정 / 사이즈를 직접 변경은 안된다고 함)
        $0.addTarget(self, action: #selector(onClickSwitch(_:)), for: .valueChanged)
    }
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.Background.darkGray02
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    @objc func onClickSwitch(_ sender: UISwitch){
        print("--> \(sender.isOn)")
    }
    
    func setUI(){
        self.addSubview(explainLabel)
        self.addSubview(controlSwitch)
        
        explainLabel.snp.makeConstraints{
            $0.centerY.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16.0)
        }
        
        controlSwitch.snp.makeConstraints{
            $0.centerY.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-16.0)
        }
    }

}
