//
//  ThirdOnboardingViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/01.
//

import UIKit

class ThirdOnboardingViewController: UIViewController {
    //MARK: - Properties
    var viewModel: OnboardingViewModel?
    var parentType: parentType?
    
    //MARK:- UI Components
    let decoLabel = UILabel().then{
        $0.text = "Q."
        $0.font = UIFont.TTFont(type: .MontReg, size: 25)
        $0.textColor = .white
    }
    
    let questionLabel = UILabel().then{
        $0.text = "선호하는 전시회의 분위기는 ?"
        $0.font = UIFont.TTFont(type: .SDMed, size: 15)
        $0.textColor = .white
    } 
    
    lazy var backBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(back(_:))).then{
        $0.image = UIImage(named: "ic_arrow")
        $0.tintColor = .white
    }
    
    lazy var topView = QuestionBtnView().then{
        $0.delegate = self
        $0.tag = 1
    }
    lazy var centerView = QuestionBtnView().then{
        $0.delegate = self
        $0.tag = 2
    }
    lazy var bottomView = QuestionBtnView().then{
        $0.delegate = self
        $0.tag = 3
    }
    
    let stackView = UIStackView().then{
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 16
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.Background.black02
        
        setNavigationItem()
        setUI()
        setConfig()
    }
    
    //MARK: - Functions
    
    @objc func back(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setConfig(){
        guard let viewModel = viewModel else { return }

        topView.config(question: viewModel.onboardManager.getAnalysisResult()[4])
        centerView.config(question: viewModel.onboardManager.getAnalysisResult()[5])
        bottomView.config(question: viewModel.onboardManager.getAnalysisResult()[6])
    }
    
    func setUI(){
        self.view.addSubview(decoLabel)
        self.view.addSubview(questionLabel)
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(topView)
        stackView.addArrangedSubview(centerView)
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
            $0.height.equalTo(102.0)
        }
        
        centerView.snp.makeConstraints{
            $0.width.equalTo(234.0)
            $0.height.equalTo(102.0)
        }
        
        bottomView.snp.makeConstraints{
            $0.width.equalTo(234.0)
            $0.height.equalTo(102.0)
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

//MARK: - Extension

extension ThirdOnboardingViewController: OnboardingViewDelegate{
    func moveToNext(tag: Int) {
        //TODO: 1. 화면 이동   /   2. 사용자 입력 저장
        guard let viewModel = self.viewModel else { return }
        viewModel.onboardManager.addUserInput(input: tag)
        
        let fourthVC = FourthOnboardingViewController()
        fourthVC.parentType = self.parentType
        fourthVC.viewModel = viewModel
        
        self.navigationController?.pushViewController(fourthVC, animated: true)
    }
}
