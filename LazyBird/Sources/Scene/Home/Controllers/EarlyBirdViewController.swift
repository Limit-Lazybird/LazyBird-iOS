//
//  HomeViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/26.
//

import UIKit
import SnapKit
import Then

class EarlyBirdViewController: UIViewController {
    let topContainerView = TopContainerView()
    lazy var appTitleLabel = UILabel().then{
        let text = "Take\nYour EarlyBird"
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.Point.or01, range: (text as NSString).range(of: "EarlyBird"))
        $0.text = text
        $0.font = UIFont.boldSystemFont(ofSize: 32)
        $0.textColor = .white
        $0.numberOfLines = 2
        $0.attributedText = attributeString
    }
    
    let earlyBirdContainerView = EarlyBirdContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Background.bgBorder
        
        setNavigationItem()
        setUI()
    }

    func setNavigationItem(){
        self.navigationController?.isNavigationBarHidden = true
//        self.navigationController?.navigationBar.shadowImage = colorToImage() -> shadow 지우기
    }
    
    private func colorToImage() -> UIImage {
        let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        let image: UIImage = UIGraphicsImageRenderer(size: size).image { context in
            UIColor.Background.bgBorder.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        return image
    }
    
    func setUI(){
        self.view.addSubview(topContainerView)
        self.view.addSubview(appTitleLabel)
        self.view.addSubview(earlyBirdContainerView)
        
        topContainerView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(50.0)
        }
        
        appTitleLabel.snp.makeConstraints{
            $0.top.equalTo(topContainerView.snp.bottom).offset(38.0)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(24.0)
        }
    
        earlyBirdContainerView.snp.makeConstraints{
            $0.top.equalTo(appTitleLabel.snp.bottom)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
