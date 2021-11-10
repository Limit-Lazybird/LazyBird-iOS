//
//  TopContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/27.
//

import UIKit

class TopContainerView: UIView {
    let logoBtn = UIImageView().then{
        $0.image = UIImage(named: "logo2")
        $0.contentMode = .scaleAspectFill
    }
    private let stackView = UIStackView().then{
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 12
    }
    
    lazy var alertBtn = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "bell"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
    }
    lazy var earlyCardBtn = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "earlyCard"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        self.addSubview(logoBtn)
        self.addSubview(stackView)
        stackView.addArrangedSubview(alertBtn)
        stackView.addArrangedSubview(earlyCardBtn)
        
        
        logoBtn.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16.0)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10.0)
            $0.width.height.equalTo(40.0)
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(13.0)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(16.0)
        }
        
        earlyCardBtn.snp.makeConstraints{
            $0.width.height.equalTo(24.0)
        }
        
        alertBtn.snp.makeConstraints{
            $0.width.height.equalTo(24.0)
        }
    }
}
