//
//  EarlyBirdContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/27.
//

import UIKit

class EarlyBirdContainerView: UIView {
    
    let dummyImageUrl: [String] = ["test","test","test","test","test","test","test","test","test"]
    
    private let layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 16
        $0.minimumInteritemSpacing = 16
    }
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then{
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = UIColor.Background.bgBorder
        $0.showsHorizontalScrollIndicator = false
        $0.register(EarlyBirdCell.self, forCellWithReuseIdentifier: EarlyBirdCell.identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints{
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

extension EarlyBirdContainerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyImageUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EarlyBirdCell.identifier, for: indexPath) as? EarlyBirdCell else {
            return UICollectionViewCell()
        }
        
        cell.config(imageUrl: dummyImageUrl[indexPath.row])
        
        return cell
    }
    
    
}

extension EarlyBirdContainerView: UICollectionViewDelegate {
    
}

extension EarlyBirdContainerView: UICollectionViewDelegateFlowLayout {
    
    // cell의 width, height 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 16.0
        let width: CGFloat = collectionView.frame.width - (margin * 2)
        let height: CGFloat = EarlyBirdCell.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           let inset: CGFloat = 16.0
           return UIEdgeInsets(top: inset , left: 0, bottom: inset , right: 0)
    }
}
