//
//  NoticeViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit
import SnapKit
import Then

protocol NoticeViewControllerProtocol{
    func expandNotice(isSelected: Bool) // 공지 확장
}

class NoticeViewController: UIViewController {
    //MARK: - UI Components
    let titleLabel = UILabel().then{
        $0.text = "공지사항"
        $0.font = UIFont.TTFont(type: .SDBold, size: 24)
        $0.textColor = .white
    }
    
    lazy var noticeItemOne = NoticeViewItemView().then{
        $0.delegate = self
    }
    lazy var noticeItemTwo = NoticeViewItemView().then{
        $0.delegate = self
    }
    
    let contentTextOne = NoticeContentView()
    let contentTextTwo = NoticeContentView()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        print("공지사항")
        setUI()
        config()
    }
    
    //MARK: - Functions
    func config(){
        noticeItemOne.config(secText: "2021년 11월 23일", titleText: "레이지 버드 1.0.0 버전 출시")
        noticeItemTwo.config(secText: "2021년 11월 21일", titleText: "공지사항이니까 꼭 보세요.")
        contentTextOne.config(contentText: "안녕하세요 레이지버드에서 알립니다.\n레이지버드 어플이 정식 출시되었습니다.\n많은 이용 바랍니다.")
        contentTextTwo.config(contentText: "공지사항입니다. !!\n 화이팅!")
    }
    
    func setUI(){
        self.view.addSubview(titleLabel)
        self.view.addSubview(noticeItemOne)
//        self.view.addSubview(noticeItemTwo)
        self.view.addSubview(contentTextOne)
//        self.view.addSubview(contentTextTwo)
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        noticeItemOne.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(32.0)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(50.0)
        }
        
        contentTextOne.snp.makeConstraints{
            $0.top.equalTo(noticeItemOne.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
        
//        noticeItemTwo.snp.makeConstraints{
//            $0.top.equalTo(contentTextOne.snp.bottom)
//            $0.trailing.leading.equalToSuperview()
//            $0.height.equalTo(50.0)
//        }
        
//        contentTextTwo.snp.makeConstraints{
//            $0.top.equalTo(noticeItemTwo.snp.bottom)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(0)
//        }
    }
}


extension NoticeViewController: NoticeViewControllerProtocol{
    func expandNotice(isSelected: Bool){
        //TODO: stackView에 뷰넣고 레이아웃 수정
        print("expand")
        if isSelected{
            contentTextOne.snp.remakeConstraints{
                $0.top.equalTo(noticeItemOne.snp.bottom)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(0.0)
            }
//            contentTextTwo.snp.makeConstraints{
//                $0.top.equalTo(noticeItemTwo.snp.bottom)
//                $0.leading.trailing.equalToSuperview()
//                $0.height.equalTo(0)
//            }
        }else{
            contentTextOne.snp.remakeConstraints{
                $0.top.equalTo(noticeItemOne.snp.bottom)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(80.0)
            }
//            contentTextTwo.snp.makeConstraints{
//                $0.top.equalTo(noticeItemTwo.snp.bottom)
//                $0.leading.trailing.equalToSuperview()
//                $0.height.equalTo(150.0)
//            }
        }
        
    }
}
