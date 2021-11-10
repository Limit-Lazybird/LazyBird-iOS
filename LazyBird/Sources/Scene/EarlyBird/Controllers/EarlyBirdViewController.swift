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
    
}

class EarlyBirdViewController: UIViewController {
    
    //MARK: - UI Components
    
    let topContainerView = TopContainerView()
    lazy var earlyBirdContainerView = EarlyBirdContainerView().then{
        $0.vc = self
    }
    
    let todayLabel = UILabel().then{
        $0.text = "today's"
        $0.font = UIFont.boldSystemFont(ofSize: 32)
        $0.textColor = .white
    }
    
    let lazyLabel = UILabel().then{
        let text = "lazy"
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.baselineOffset, value: 0, range: (text as NSString).range(of: "lazy"))
        attributedString.addAttribute(.strikethroughStyle, value: 2, range: (text as NSString).range(of:"lazy"))
        $0.text = text
        $0.font = UIFont.boldSystemFont(ofSize: 32)
        $0.textColor = UIColor.Background.darkGray01
        $0.attributedText = attributedString
    }
    
    let ealryBirdLabel = UILabel().then{
        $0.text = "ealryBird"
        $0.textColor = UIColor.Point.or01
        $0.font = UIFont.boldSystemFont(ofSize: 36)
        $0.textAlignment = .right
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
    
    func setNavigationItem(){
        self.navigationController?.isNavigationBarHidden = true
//        self.navigationController?.navigationBar.shadowImage = colorToImage() -> shadow 지우기
    }
    
    
    
    func setUI(){
        self.view.addSubview(topContainerView)
        self.view.addSubview(todayLabel)
        self.view.addSubview(lazyLabel)
        self.view.addSubview(ealryBirdLabel)
        self.view.addSubview(earlyBirdContainerView)
        
        
        topContainerView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(50.0)
        }
        
        todayLabel.snp.makeConstraints{
            $0.top.equalTo(topContainerView.snp.bottom).offset(38.0)
            $0.trailing.equalTo(lazyLabel.snp.leading).offset(-8.0)
        }
        
        lazyLabel.snp.makeConstraints{
            $0.top.equalTo(topContainerView.snp.bottom).offset(38.0)
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        ealryBirdLabel.snp.makeConstraints{
            $0.top.equalTo(lazyLabel.snp.bottom)
            $0.leading.equalTo(lazyLabel.snp.leading)
        }
        
        earlyBirdContainerView.snp.makeConstraints{
            $0.top.equalTo(ealryBirdLabel.snp.bottom)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
