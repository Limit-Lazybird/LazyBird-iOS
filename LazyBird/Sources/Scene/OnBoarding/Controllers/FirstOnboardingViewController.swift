//
//  FirstOnboardingViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/31.
//

import UIKit
import SnapKit
import Then

protocol OnboardingViewDelegate{
    func moveToNext()
}

class FirstOnboardingViewController: UIViewController {
    
    //MARK:- UI Components
    
    let decoLabel = UILabel().then{
        $0.text = "Q."
        $0.font = UIFont.boldSystemFont(ofSize: 25)
        $0.textColor = .white
    }
    
    let questionLabel = UILabel().then{
        $0.text = "전시회를 방문하는 목적은 ?"
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = .white
    }
    
    lazy var backBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(back(_:))).then{
        $0.image = UIImage(named: "ic_arrow")
        $0.tintColor = .white
    }
    
    lazy var topView = QuestionBtnView().then{
        $0.delegate = self
    }
    lazy var bottomView = QuestionBtnView().then{
        $0.delegate = self
    }
    
    let stackView = UIStackView().then{
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 16
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
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUI(){
        self.view.addSubview(decoLabel)
        self.view.addSubview(questionLabel)
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(topView)
        stackView.addArrangedSubview(bottomView)
        
        decoLabel.snp.makeConstraints{
            $0.leading.equalTo(stackView.snp.leading)
            $0.bottom.equalTo(questionLabel.snp.top).offset(-9.0)
        }
        
        questionLabel.snp.makeConstraints{
            $0.leading.equalTo(stackView.snp.leading)
            $0.bottom.equalTo(stackView.snp.top).offset(-25.0)
        }
        
        stackView.snp.makeConstraints{
            $0.centerX.centerY.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        topView.snp.makeConstraints{
            $0.width.equalTo(234.0)
            $0.height.equalTo(162.0)
        }
        
        bottomView.snp.makeConstraints{
            $0.width.equalTo(234.0)
            $0.height.equalTo(162.0)
        }
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
    
    private func colorToImage() -> UIImage {
        let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        let image: UIImage = UIGraphicsImageRenderer(size: size).image { context in
            UIColor.Background.black02.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        return image
    }
}


extension FirstOnboardingViewController: OnboardingViewDelegate {
    func moveToNext() {
        let secondVC = SecondOnboardingViewController()
        
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}
