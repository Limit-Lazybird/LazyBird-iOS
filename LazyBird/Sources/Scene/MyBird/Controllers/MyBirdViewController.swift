//
//  MyBirdViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit
import SnapKit
import Then
import Alamofire

protocol MyBirdViewControllerProtocol{
    func moveToReservedExhibitDetail() // 예매한 전시로 이동
    func moveToFavoriteExhibitDetail() // 좋아요 전시로 이동
}

class MyBirdViewController: UIViewController {
    //MARK: - Properties
    let viewModel = MyBirdViewModel()
    
    //MARK: - UI Components
    lazy var settingBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(settingBtnPressed(_:))).then{
        $0.image = UIImage(named: "ic_setting")
        $0.tintColor = .white
    }
    
    lazy var mybirdUserInfoView = MyBirdUserInfoView()
    lazy var mybirdReservedExhibitionView = MyBirdReservedExhibitionView().then{
        $0.delegate = self
    }
    lazy var myBirdFavoriteExhibitionView = MyBirdFavoriteExhibitionView().then{
        $0.delegate = self
    }
    
    private let scrollView = UIScrollView().then{
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView()
    
    lazy var stackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 16.0
        $0.addArrangedSubview(mybirdUserInfoView)
        $0.addArrangedSubview(mybirdReservedExhibitionView)
        $0.addArrangedSubview(myBirdFavoriteExhibitionView)
    }
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        setNavigationItem()
        setUI()
        setBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.viewModel.requestFavoriteExhibits()
        self.viewModel.requestReservationExhibits()
        self.viewModel.requestUserInfo()
//        setConfig()
    }
    
    //MARK: - Functions
    @objc func settingBtnPressed(_ sender: Any){
        let settingVC = SettingViewController()
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    func setBind(){
        self.viewModel.favoriteExhibits.bind { exhibits in
            print("favoriteExhibits bind 호출")
            self.setConfig()
        }
        
        self.viewModel.reservationExhibits.bind { exhibits in
            print("reservationExhibits bind 호출")
            self.setConfig()
        }
        
        self.viewModel.userInfo.bind { userInfo in
            print("userInfo bind 호출")
            self.setConfig()
        }
    }
    
    func setConfig(){
        mybirdUserInfoView.config(viewModel: self.viewModel)
        myBirdFavoriteExhibitionView.config(exhibit: self.viewModel.favoriteExhibits.value)
        mybirdReservedExhibitionView.config(exhibit: self.viewModel.reservationExhibits.value)
    }
    
    func setUI(){
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(32.0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setNavigationItem(){
        self.navigationItem.title = "마이버드"
        self.navigationItem.rightBarButtonItems = [settingBtn]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.Background.black02
        self.navigationController?.navigationBar.shadowImage = colorToImage()
        self.navigationController?.navigationBar.isTranslucent = false
        // navigationbar backbutton 설정
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_arrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_arrow")
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

extension MyBirdViewController: MyBirdViewControllerProtocol{
    func moveToFavoriteExhibitDetail() {
        //TODO: 찜한 전시로 이동
        print("찜한 전시로 이동")
        let favoriteVC = FavoriteExhibitDetailViewController()
        favoriteVC.viewModel = self.viewModel
        
        self.navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
    func moveToReservedExhibitDetail() {
        //TODO: 예매한 전시로 이동
        print("예매한 전시로 이동")
        let reservationVC = ReservedExhibitViewController()
        reservationVC.viewModel = self.viewModel
        
        self.navigationController?.pushViewController(reservationVC, animated: true)
    }
}
