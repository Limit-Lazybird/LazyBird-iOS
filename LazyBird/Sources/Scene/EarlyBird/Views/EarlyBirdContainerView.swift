//
//  EarlyBirdContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/27.
//

import UIKit
import CollectionViewPagingLayout

class EarlyBirdContainerView: UIView {
    
    //MARK: - Properties
    let dummyImageUrl: [String] = ["test","test","test","test","test","test","test","test","test"]
    var vc: UIViewController?
    
    //MARK: - UI Components
    
    let layout = CollectionViewPagingLayout().then{
        $0.numberOfVisibleItems = nil
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then{
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .clear
        $0.decelerationRate = .fast
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = self.vc else { return }
        
        let ExhibitDetailVC = ExhibitDetailViewController()
        ExhibitDetailVC.hidesBottomBarWhenPushed = true
        vc.navigationController?.pushViewController(ExhibitDetailVC, animated: true)
    }
}

extension EarlyBirdContainerView: UICollectionViewDelegateFlowLayout {
    
    // cell의 width, height 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 29.0
        let width: CGFloat = collectionView.frame.width - (margin * 2)
        let height: CGFloat = collectionView.frame.height - 83.0
        
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
        return UIEdgeInsets(top: 30.0 , left: 29.0, bottom: 53.0 , right: 29.0)
    }
}
