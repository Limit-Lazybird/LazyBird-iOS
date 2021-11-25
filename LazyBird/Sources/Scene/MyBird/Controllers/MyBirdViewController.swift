//
//  MyBirdViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit
import SnapKit
import Then

protocol MyBirdViewControllerProtocol{
    func moveToReservedExhibitDetail() // 예매한 전시로 이동
    func moveToFavoriteExhibitDetail() // 좋아요 전시로 이동
}

class MyBirdViewController: UIViewController {
    //MARK: - UI Components
    lazy var earlyCardBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(earlyCardPressed(_:))).then{
        $0.image = UIImage(named: "earlyCard")
        $0.tintColor = .white
    }
    
    let mybirdUserInfoView = MyBirdUserInfoView() // 유저정보 뷰
    let mybirdReservedExhibitionView = MyBirdReservedExhibitionView()
    let myBirdFavoriteExhibitionView = MyBirdFavoriteExhibitionView()
    
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
        setConfig()
    }
    
    //MARK: - Functions
    @objc func earlyCardPressed(_ sender: Any){
        print("earlyCardBtn pressed")
    }
    
    func setConfig(){
        mybirdUserInfoView.config()
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
            $0.edges.equalToSuperview()
        }
    }
    
    func setNavigationItem(){
        self.navigationItem.title = "마이버드"
        self.navigationItem.rightBarButtonItems = [earlyCardBtn]
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
    }
    
    func moveToReservedExhibitDetail() {
        //TODO: 예매한 전시로 이동
    }
}
