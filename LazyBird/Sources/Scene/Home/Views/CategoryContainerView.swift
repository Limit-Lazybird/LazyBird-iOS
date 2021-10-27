//
//  CategoryContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/27.
//

import UIKit

class CategoryContainerView: UIView {
    var dummyCategory: [String] = ["현대미술","사진전","콘서트","무용","잡다잡다해","잡다잡다해","잡다잡다해","잡다잡다해"]
    
    private let layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = .zero
        $0.minimumInteritemSpacing = 4
    }
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then{
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = UIColor.Background.bgBorder
        $0.showsHorizontalScrollIndicator = false
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
            $0.top.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16.0)
        }
    }
}

extension CategoryContainerView: UICollectionViewDelegate{
    
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
}

extension CategoryContainerView: UICollectionViewDelegateFlowLayout {

    // cell의 width, height 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CategoryCell.fittingSize(availableHeight: CategoryCell.height,
                                        name: dummyCategory[indexPath.row])
    }
           // Header의 width, height 설정
//       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//           CGSize(width: 50, height: 48.0)
//       }
}
