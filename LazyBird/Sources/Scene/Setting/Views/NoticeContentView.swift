//
//  NoticeContentView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit

class NoticeContentView: UIView {
    
    let contentTextView = UITextView().then{
        $0.backgroundColor = UIColor.Background.darkGray02
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textAlignment = NSTextAlignment.left
        $0.isEditable = false
        $0.textColor = .white
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        $0.text = "안녕하세요 레이지버드에서 알립니다. 레이지버드 어플의 1.0.1 버전이 앱스토어와 플레이스토어에 정식 출시되었습니다. 편리한 어떤 기능과 그런 기능을 추가했습니다. 지금 바로 다운받아보실 수 있습니다. 꼭 다운받아보세요. 잘부탁드립니다. 언제나 화이팅입니다 아자아자 화이팅 ~"
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
    func config(contentText: String){
        self.contentTextView.text = contentText
    }
    
    func setUI(){
        self.addSubview(contentTextView)
        
        contentTextView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
