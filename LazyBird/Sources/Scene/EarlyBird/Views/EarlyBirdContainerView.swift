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
    var delegate: EarlyBirdViewDelegate?
    var viewModel: EarlyBirdViewModelProtocol?
    
    //MARK: - UI Components
    
    lazy var layout = CollectionViewPagingLayout().then{
        $0.numberOfVisibleItems = nil
        $0.delegate = self
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
    
    //MARK: - Life Cycle
    
    override func didMoveToSuperview() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.earlyBirds.bind { exhibits in
            self.collectionView.reloadData()
            self.layout.invalidateLayoutInBatchUpdate() // 시이이ㅣㅇ이이이이이바라라라아아알라라라라ㅏ라라라랄라라라라이걸였냐 !
        }
        viewModel.fetchEarlyBirds()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func setUI(){
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints{
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

extension EarlyBirdContainerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else { return 0 }
        return viewModel.earlyBirds.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EarlyBirdCell.identifier, for: indexPath) as? EarlyBirdCell else {
            return UICollectionViewCell()
        }
        
        if let viewModel = self.viewModel {
            if let imageUrl = viewModel.earlyBirds.value[indexPath.row].exhbt_sn{
                cell.config(imageUrl: imageUrl)
            }else{
                print("exhbt_sn is nil")
            }
        }else{
            print("collectionViewCell's viewModel is nil")
        }
        
        return cell
    }
    
    
}

extension EarlyBirdContainerView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.moveToDetailView()
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

extension EarlyBirdContainerView: CollectionViewPagingLayoutDelegate{
    func onCurrentPageChanged(layout: CollectionViewPagingLayout, currentPage: Int) {
    }
}
