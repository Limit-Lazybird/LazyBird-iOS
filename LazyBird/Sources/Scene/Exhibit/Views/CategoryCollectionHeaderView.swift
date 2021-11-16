//
//  CategoryCollectionHeaderView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/15.
//

import UIKit
import SnapKit
import Then

class CategoryCollectionHeaderView: UICollectionReusableView {
    
    //MARK: - Properties
    
    static let identifier = "categoryCollectionHeaderView"
    static let height = 26.0
    
    var delegate: ExhibitViewDelegate?
    
    //MARK: - UI Components
    
    let headerImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "filter")
    }
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.Background.black02
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    @objc func headerViewTapped(_ sender: Any){
        print("headerView Tapped")
        
        guard let delegate = self.delegate else { return }
        
        delegate.moveToExhibitFilter()
    }
    
    func setupViews(){
        self.backgroundColor = UIColor.Background.darkGray01
        self.layer.cornerRadius = 26 / 2
        
        self.addSubview(headerImageView)

        headerImageView.snp.makeConstraints{
            $0.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
            $0.width.height.equalTo(24.0)
        }
    }
}
