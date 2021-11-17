//
//  HomeViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/26.
//

import UIKit
import SnapKit
import Then

protocol EarlyBirdViewDelegate{
    func moveToDetailView()
}

class EarlyBirdViewController: UIViewController {
    
    //MARK: - Properties
    let viewModel = EarlyBirdViewModel()
    
    //MARK: - UI Components
    lazy var backBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: nil).then{
        $0.image = UIImage(systemName: "ic_arrow")
        $0.tintColor = .white
    }
    
    lazy var logoBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(logoBtnPressed(_:))).then{
        $0.image = UIImage(named: "logo2")
        $0.tintColor = UIColor.Point.or01
    }
    
    lazy var alertBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(alertBtnPressed(_:))).then{
        $0.image = UIImage(named: "bell")
        $0.tintColor = .white
    }
    
    lazy var earlyCardBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(earlyCardPressed(_:))).then{
        $0.image = UIImage(named: "earlyCard")
        $0.tintColor = .white
    }
    
    let mainTextImageView = UIImageView().then{
        $0.image = UIImage(named: "main_text")
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var earlyBirdContainerView = EarlyBirdContainerView(frame: .zero).then{
        $0.delegate = self
        $0.viewModel = self.viewModel
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Background.black02
        
        setNavigationItem()
        setUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //MARK: - Functions
    
    @objc func logoBtnPressed(_ sender: Any){
        print("logoBtn pressed")
    }
    
    @objc func alertBtnPressed(_ sender: Any){
        print("alertBtn pressed")
    }
    
    @objc func earlyCardPressed(_ sender: Any){
        print("earlyCardBtn pressed")
    }
    
    func setNavigationItem(){
        // navigation tint, shadow 설정
        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.barTintColor = UIColor.Background.black02
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = colorToImage()
        // navigationbar left, right 버튼 설정
        self.navigationItem.leftBarButtonItem = logoBtn
        self.navigationItem.rightBarButtonItems = [alertBtn, earlyCardBtn]
        // navigationbar backbutton 설정
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_arrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_arrow")
        // Title 설정
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func setUI(){
        self.view.addSubview(mainTextImageView)
        self.view.addSubview(earlyBirdContainerView)
        
        mainTextImageView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(24.0)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(54.0)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-54.0)
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(mainTextImageView.snp.width).multipliedBy(0.234375)
        }
        
        earlyBirdContainerView.snp.makeConstraints{
            $0.top.equalTo(mainTextImageView.snp.bottom)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
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

extension EarlyBirdViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        //TODO: rootView가 최상단 뷰일때, navigationBar 나타내기
//        print("will show")
        if viewController == navigationController.viewControllers.first {
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        print("did show")
        if viewController == navigationController.viewControllers.first {
            self.navigationController?.navigationBar.isHidden = false
        }
    }
}

extension EarlyBirdViewController: EarlyBirdViewDelegate{
    func moveToDetailView() {
        let ExhibitDetailVC = ExhibitDetailViewController()
        ExhibitDetailVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(ExhibitDetailVC, animated: true)
    }
}


