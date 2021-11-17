//
//  CategoryContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/27.
//

import UIKit

class CategoryContainerView: UIView {
    //MARK: - Properties
    var delegate: ExhibitViewDelegate?
    var dummyCategory: [String] = ["회화","조형","사진","특별전","아동전시","잡다잡다해","잡다잡다해","잡다잡다해"]
    
    //MARK: - UI Components
    
    private let layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = .zero
        $0.minimumInteritemSpacing = 8
    }
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then{
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 8.0, bottom: 0, right: 0)
        $0.allowsMultipleSelection = true
        $0.register(CategoryCollectionHeaderView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: CategoryCollectionHeaderView.identifier)
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
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

extension CategoryContainerView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: 1. 서버에서 필터링 해줄건지?
        // TODO: 2. 그냥 전체 리스트를 받아와서 내가 스스로 필터링을 할건지?? <- 아마 이 방법으로 하지 않을까 싶다
        // let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell
        // cell?.selectedCell()
    }
}

extension CategoryContainerView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dummyCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        cell.config(category: dummyCategory[indexPath.row])
        
        return cell
    }
    
    // header view setting
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            kind == UICollectionView.elementKindSectionHeader,
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CategoryCollectionHeaderView.identifier,
                for: indexPath
            ) as? CategoryCollectionHeaderView
        else { return UICollectionReusableView() }

        header.setupViews()
        header.delegate = self.delegate

        return header
    }
}

extension CategoryContainerView: UICollectionViewDelegateFlowLayout {

    // cell의 width, height 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CategoryCell.fittingSize(availableHeight: CategoryCell.height,
                                        name: dummyCategory[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8.0, bottom: 0, right: 16.0)
    }
    
    
           // Header의 width, height 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 53.0, height: CategoryCollectionHeaderView.height)
    }
}