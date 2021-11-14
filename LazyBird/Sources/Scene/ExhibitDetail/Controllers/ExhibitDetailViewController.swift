//
//  EarlyBirdDetailViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/10.
//

import UIKit
import SnapKit
import Then

class ExhibitDetailViewController: UIViewController {
    
    //MARK: - UI Components
    private let scrollView = UIScrollView().then{
        $0.contentInsetAdjustmentBehavior = .never
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    
    lazy var backBtn = UIButton().then{
        $0.setImage(UIImage(named: "ic_arrow"), for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
    }
    
    let bookContainerView = TicketBookContainerView(frame: .zero)
    
    lazy var stackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 0.0
        $0.backgroundColor = .white
        $0.addArrangedSubview(ExhibitImageContainerView(frame: .zero))
        $0.addArrangedSubview(ExhibitInfoContainerView(frame: .zero))
        $0.addArrangedSubview(SeparatorView(frame: .zero))
        $0.addArrangedSubview(ExhibitGuideContainerView(frame: .zero))
        $0.addArrangedSubview(SeparatorView(frame: .zero))
        $0.addArrangedSubview(ExhibitContentContainerView(frame: .zero))
        $0.addArrangedSubview(SeparatorView(frame: .zero))
    }

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        setUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Functions
    
    @objc func back(_ sender: UIButton){
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUI(){
        self.view.addSubview(scrollView)
        self.view.addSubview(backBtn)
        self.view.addSubview(bookContainerView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        backBtn.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(12.0)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(13.0)
        }

        scrollView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(bookContainerView.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        bookContainerView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(86.0)
        }

    }
}

//func setNavigationItem(){
//        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationBar.shadowImage = colorToImage()  //-> shadow 지우기
//        self.navigationItem.leftBarButtonItem = self.backBtn
//
//        // Title 설정
//        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//        self.navigationController?.navigationBar.barTintColor = UIColor.Background.black02
//        self.navigationController?.navigationBar.isTranslucent = false
//    }
//
//    private func colorToImage() -> UIImage {
//        let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
//        let image: UIImage = UIGraphicsImageRenderer(size: size).image { context in
//            UIColor.Background.black02.setFill()
//            context.fill(CGRect(origin: .zero, size: size))
//        }
//        return image
//    }
