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
    let categoryContainerView = CategoryContainerView()
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
        self.view.addSubview(categoryContainerView)
        self.view.addSubview(earlyBirdContainerView)
        
        topContainerView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(50.0)
        }
        
        categoryContainerView.snp.makeConstraints{
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.top.equalTo(topContainerView.snp.bottom).offset(16.0)
            $0.height.equalTo(35.0) //26
        }
        
        earlyBirdContainerView.snp.makeConstraints{
            $0.top.equalTo(categoryContainerView.snp.bottom)
            $0.leading.bottom.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
