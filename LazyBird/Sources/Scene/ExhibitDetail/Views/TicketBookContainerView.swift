//
//  TicketBookContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/10.
//

import UIKit
import SnapKit
import Then

/*
 1. 예매하러가기 버튼
 */

class TicketBookContainerView: UIView {
    //MARK: - Properties
    var delegate: ExhibitDetailViewControllerDelegate?
    
    //MARK: - UI Components
    let bgView = UIView().then{
        $0.backgroundColor = UIColor.Background.darkGray01
    }
    
    lazy var bookBtn = UIButton().then{
        $0.backgroundColor = UIColor.Point.or01
        $0.setTitle("예매하러 가기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(bookBtnPressed(_:)), for: .touchUpInside)
    }
    
    //MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    @objc func bookBtnPressed(_ sender: UIButton){
        self.delegate?.moveToNotice()
    }
    
    func setUI(){
        self.addSubview(bgView)
        bgView.addSubview(bookBtn)
        
        bgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        bookBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(9.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.height.equalTo(48.0)
        }
    }
}
