//
//  QuestionBtnView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/01.
//

import UIKit
import SnapKit
import Then

class QuestionBtnView: UIView {
    /*
     TODO: 나중에 Delegate 넣어서 버튼의 액션을 VC로 전달하자
     TODO: 서버에서 넘어온 질문, 이미지들 binding 하자
     */
    
    //MARK: - Properties
    var delegate: OnboardingViewDelegate?

    //MARK: - UI Components
    
    lazy var bgImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var bgBtn = UIButton().then{
        $0.backgroundColor = UIColor.Opacity.black70
        $0.addTarget(self, action: #selector(moveToNext(_:)), for: .touchUpInside)
    }
    
    lazy var questionLabel = UILabel().then{
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 4
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = .white
    }
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    @objc func moveToNext(_ sender: Any){
        //TODO: 누른거 싱글턴 매니저에 저장하기
        //TODO: delegate로 다음페이지 넘기기
        guard let delegate = self.delegate else { return }
        
        delegate.moveToNext(tag: self.tag)
    }
    
    func config(question: String, url: String){
        self.bgImageView.kf.setImage(with: URL(string: url))
        self.questionLabel.text = question
    }
    
    func setUI(){
        self.addSubview(bgImageView)
        self.addSubview(bgBtn)
        self.addSubview(questionLabel)
        
        bgImageView.snp.makeConstraints{
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        bgBtn.snp.makeConstraints{
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        questionLabel.snp.makeConstraints{
            $0.top.leading.equalTo(self.safeAreaLayoutGuide).offset(16.0)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(16.0)
        }
    }
}
