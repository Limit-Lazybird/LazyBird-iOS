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
    func moveToResetOnboard()
    func moveToExhibitFilter()
    func moveToDetailView(indexPath: IndexPath)
    func updateFilteredExhibit(filteredExhibit: Exhibits)
}

class ExhibitViewController: UIViewController {
    //MARK: - Properies
    let viewModel = ExhibitViewModel()
    
    //MARK: - UI Components
    
    lazy var alertBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(alertBtnPressed(_:))).then{
        $0.image = UIImage(named: "bell")
        $0.tintColor = .white
    }
    
    lazy var earlyCardBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(earlyCardPressed(_:))).then{
        $0.image = UIImage(named: "earlyCard")
        $0.tintColor = .white
    }
    
    lazy var toggleView = CustomExhibitToggleView(frame: .zero).then{
        $0.delegate = self
    }
    lazy var categoryContainerView = CategoryContainerView(frame: .zero).then{
        $0.viewModel = self.viewModel
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
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("ExhibitViewController  view will appear")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Functions
    
    func configure(){
        self.exhibitContainerView.config(viewModel: self.viewModel)
        self.toggleView.config(viewModel: self.viewModel)
    }
    
    @objc func alertBtnPressed(_ sender: Any){
        print("alertBtn pressed")
    }
    
    @objc func earlyCardPressed(_ sender: Any){
        let earlyCardListVC = EarlyCardListViewController()
        
        self.navigationController?.pushViewController(earlyCardListVC, animated: true)
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
        self.navigationItem.rightBarButtonItems = [earlyCardBtn]
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
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == navigationController.viewControllers.first {
            self.navigationController?.navigationBar.isHidden = false
        }
    }
}

extension ExhibitViewController: ExhibitViewDelegate{
    func moveToResetOnboard() {
        let resetOnboardingVC = ResetOnboardAlertViewController()
        resetOnboardingVC.modalPresentationStyle = .overFullScreen
        
        self.present(resetOnboardingVC, animated: true, completion: nil)
    }
    
    func moveToExhibitFilter() {
        let exhibitFilterVC = ExhibitFilterViewController()
        exhibitFilterVC.delegate = self
        exhibitFilterVC.modalPresentationStyle = .overFullScreen
        
        self.present(exhibitFilterVC, animated: true, completion: nil)
    }
    
    func moveToDetailView(indexPath: IndexPath) {
        let exhibitDetailVC = ExhibitDetailViewController()
        exhibitDetailVC.hidesBottomBarWhenPushed = true
        exhibitDetailVC.exhibitDetailViewModel.setExhibit(self.viewModel.getExhibits().value[indexPath.row])
        self.navigationController?.pushViewController(exhibitDetailVC, animated: true)
    }
    
    func updateFilteredExhibit(filteredExhibit: Exhibits){
        self.viewModel.updateFilteredExhibits(exhibits: filteredExhibit)
    }
}


