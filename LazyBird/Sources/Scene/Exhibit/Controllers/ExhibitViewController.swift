//
//  ExhibitViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/14.
//

import UIKit
import SnapKit
import Then

protocol ExhibitViewDelegate{
    func moveToExhibitFilter()
    func moveToDetailView()
}

class ExhibitViewController: UIViewController {
    
    //MARK: - UI Components
    
    lazy var alertBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(alertBtnPressed(_:))).then{
        $0.image = UIImage(named: "bell")
        $0.tintColor = .white
    }
    
    lazy var earlyCardBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(earlyCardPressed(_:))).then{
        $0.image = UIImage(named: "earlyCard")
        $0.tintColor = .white
    }
    
    let toggleView = CustomExhibitToggleView(frame: .zero)
    lazy var categoryContainerView = CategoryContainerView(frame: .zero).then{
        $0.delegate = self
    }
    lazy var exhibitContainerView = ExhibitContainerView(frame: .zero).then{
        $0.delegate = self
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        setNavigationItem()
        setUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Functions
    
    @objc func alertBtnPressed(_ sender: Any){
        print("alertBtn pressed")
    }
    
    @objc func earlyCardPressed(_ sender: Any){
        print("earlyCardBtn pressed")
    }
    
    func setUI(){
        self.view.addSubview(toggleView)
        self.view.addSubview(categoryContainerView)
        self.view.addSubview(exhibitContainerView)
    
        toggleView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(52.0)
        }
        
        categoryContainerView.snp.makeConstraints{
            $0.top.equalTo(toggleView.snp.bottom).offset(16.0)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(26.0)
        }
        
        exhibitContainerView.snp.makeConstraints{
            $0.top.equalTo(categoryContainerView.snp.bottom).offset(16.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func setNavigationItem(){
        self.navigationItem.title = "전시"
        self.navigationController?.delegate = self
        self.navigationItem.rightBarButtonItems = [alertBtn, earlyCardBtn]
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.shadowImage = colorToImage()
        // Title 설정
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.Background.black02
        self.navigationController?.navigationBar.isTranslucent = false
        // navigationbar backbutton 설정
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_arrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_arrow")
        // Title 설정
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
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


extension ExhibitViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        //TODO: rootView가 최상단 뷰일때, navigationBar 나타내기
        if viewController == navigationController.viewControllers.first {
            self.navigationController?.navigationBar.isHidden = false
        }
    }
}

extension ExhibitViewController: ExhibitViewDelegate{
    func moveToExhibitFilter() {
        let exhibitFilterVC = ExhibitFilterViewController()
        exhibitFilterVC.modalPresentationStyle = .overFullScreen
        
        self.present(exhibitFilterVC, animated: true, completion: nil)
    }
    
    func moveToDetailView() {
        let ExhibitDetailVC = ExhibitDetailViewController()
        ExhibitDetailVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(ExhibitDetailVC, animated: true)
    }
}


