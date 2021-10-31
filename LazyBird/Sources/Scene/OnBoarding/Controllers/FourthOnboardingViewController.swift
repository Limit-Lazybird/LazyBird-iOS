//
//  FourthOnboardingViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/01.
//

import UIKit
import SnapKit
import Then

/*
 let text = "Take\nYour EarlyBird"
 let attributeString = NSMutableAttributedString(string: text)
 attributeString.addAttribute(.foregroundColor, value: UIColor.Point.or01, range: (text as NSString).range(of: "EarlyBird"))
 $0.attributedText = attributeString
 */


class FourthOnboardingViewController: UIViewController {
    
    //MARK: - UI Components
    
    let mainImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "ic_onb4_main")
    }
    
    let welcomeLabel = UILabel().then{
        let text = "선택한 답변으로 당신의 취향에\n꼭 맞는 전시회를 추천해드릴 준비가\n끝났습니다."
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.black, range: (text as NSString).range(of: "당신의 취향에\n꼭 맞는 전시회를 추천"))
        attributeString.addAttribute(.backgroundColor, value: UIColor.Point.or01, range: (text as NSString).range(of:"당신의 취향에\n꼭 맞는 전시회를 추천"))
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 3
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.attributedText = attributeString
    }
    
    lazy var startBtn = UIButton().then{
        $0.backgroundColor = UIColor.Point.or01
        $0.setTitle("시작하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        $0.layer.cornerRadius = 10.0
        $0.addTarget(self, action: #selector(moveToHome(_:)), for: .touchUpInside)
    }
    
    lazy var backBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(back(_:))).then{
        $0.image = UIImage(named: "ic_arrow")
        $0.tintColor = .white
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        setNavigationItem()
        setUI()
    }
    
    //MARK: - Functions
    
    @objc func back(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func moveToHome(_ sender: Any){
        //TODO: Home 화면으로 넘어가기
        //TODO: 설문 결과 서버로 전송하기
        self.dismiss(animated: true, completion: nil)
        
        let tabBarVC = TabBarViewController()
        tabBarVC.modalPresentationStyle = .fullScreen
        
        self.present(tabBarVC, animated: true, completion: nil)
    }
    
    
    func setNavigationItem(){
        self.navigationItem.title = "전시 성향 분석"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.shadowImage = colorToImage()
        self.navigationItem.leftBarButtonItem = self.backBtn
        
        // Title 설정
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.Background.black02
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func setUI(){
        self.view.addSubview(mainImageView)
        self.view.addSubview(welcomeLabel)
        self.view.addSubview(startBtn)
        
        mainImageView.snp.makeConstraints{
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
            $0.centerY.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(0.75)
            $0.width.equalTo(268.0)
            $0.height.equalTo(194.0)
        }
        
        welcomeLabel.snp.makeConstraints{
            $0.top.equalTo(mainImageView.snp.bottom).offset(self.view.frame.height * 0.08374384236)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(48.0)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-48.0)
        }
        
        startBtn.snp.makeConstraints{
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16.0)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-16.0)
            $0.centerY.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(1.8)
            $0.height.equalTo(startBtn.snp.width).multipliedBy(0.14035087719)
        }
    }
    
    private func colorToImage() -> UIImage {
        let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        let image: UIImage = UIGraphicsImageRenderer(size: size).image { context in
            UIColor.Background.black02.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        return image
    }
}
