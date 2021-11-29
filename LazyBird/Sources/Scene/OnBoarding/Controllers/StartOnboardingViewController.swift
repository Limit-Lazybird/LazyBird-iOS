//
//  StartOnboardingViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/30.
//

import UIKit
import SnapKit
import Then

enum parentType{
    case reset
}

class StartOnboardingViewController: UIViewController {
    //MARK: - Properties
    let viewModel = OnboardingViewModel()
    var parentType: parentType?
    
    //MARK: - UI Components
    let choiceAImageView = UIImageView().then{
        $0.image = UIImage(named: "choiceA")
        $0.contentMode = .scaleAspectFit
    }
    
    let choiceBImageView = UIImageView().then{
        $0.image = UIImage(named: "choiceB")
        $0.contentMode = .scaleAspectFit
    }
    
    let mainLabel = UILabel().then{
        $0.text = "3가지만\n선택하면"
        $0.font = UIFont.TTFont(type: .SDBold, size: 30)
        $0.textColor = .white
        $0.numberOfLines = 2
    }
    
    let subLabel = UILabel().then{
        $0.text = "당신의 성향의 맞는 전시회를 추천드릴게요."
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = .white
    }
    
    lazy var nextBtn = UIButton().then{
        $0.backgroundColor = UIColor.Point.or02
        $0.setTitle("전시 성향 분석하러 가기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(moveToOnboardingVC(_:)), for: .touchUpInside)
    }
    
    lazy var skipBtn = UIButton().then{
        let text = "다음에 할래요."
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: text.count))
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.addTarget(self, action: #selector(moveToHome(_:)), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        setUI()
        setNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel.requestOnboardQuestions() // 성향 질문 request
    }
    
    //MARK: - Functions
    @objc func moveToOnboardingVC(_ sender: UIButton){
        // TODO: 온보딩화면으로 이동
        let firstVC = FirstOnboardingViewController()
        firstVC.viewModel = self.viewModel
        firstVC.parentType = self.parentType
        
        self.navigationController?.pushViewController(firstVC, animated: true)
    }
    @objc func moveToHome(_ sender: UIButton){
        // TODO: 홈 화면으로 이동
        if let _ = self.parentType {
            //TODO: 재설정으로 온 경우
            self.dismiss(animated: true, completion: nil)
        }else{
            //TODO: 온보딩에서 넘어온 경우
            let tabBarVC = TabBarViewController()
            tabBarVC.modalPresentationStyle = .fullScreen
            
            self.present(tabBarVC, animated: true, completion: nil)
        }
    }
    
    func setNavigationItem(){
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUI(){
        let height = self.view.frame.height
        let width = self.view.frame.width
        
        self.view.addSubview(choiceAImageView)
        self.view.addSubview(choiceBImageView)
        self.view.addSubview(mainLabel)
        self.view.addSubview(subLabel)
        self.view.addSubview(nextBtn)
        self.view.addSubview(skipBtn)
        
        choiceAImageView.snp.makeConstraints{
            $0.centerY.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(0.5)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(width * 0.18666666666)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(width * 0.18666666666)
            $0.height.equalTo(choiceAImageView.snp.width).multipliedBy(0.68936170212)
        }
        choiceBImageView.snp.makeConstraints{
            $0.top.equalTo(choiceAImageView.snp.bottom).offset(16.0)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(width * 0.18666666666)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(width * 0.18666666666)
            $0.height.equalTo(choiceAImageView.snp.width).multipliedBy(0.68936170212)
        }
        mainLabel.snp.makeConstraints{
            $0.top.equalTo(choiceBImageView.snp.bottom).inset(22.0)
            $0.leading.equalTo(choiceBImageView.snp.leading)
        }
        subLabel.snp.makeConstraints{
            $0.top.equalTo(mainLabel.snp.bottom).offset(20.0)
            $0.leading.equalTo(mainLabel.snp.leading)
        }
        
        nextBtn.snp.makeConstraints{
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(17.0)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(17.0)
            $0.height.equalTo(nextBtn.snp.width).multipliedBy(0.140)
            $0.bottom.equalToSuperview().inset(height * 0.11083743842)
        }
        
        skipBtn.snp.makeConstraints{
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().inset(height * 0.06527093596)
        }
    }
}


