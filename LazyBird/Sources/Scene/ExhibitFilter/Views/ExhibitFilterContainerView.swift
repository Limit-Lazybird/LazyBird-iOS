//
//  ExhibitFilterContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/16.
//

import UIKit
import SnapKit
import Then

class ExhibitFilterContainerView: UIView {

    //test
    var filterItem: [String] = [String]()
    
    let filterTypeLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.textColor = .white
    }
    
    let layout = ExhibitFilterCollectionViewFlowlayout().then{
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 8
        $0.minimumInteritemSpacing = 4
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then{
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.allowsMultipleSelection = true
        $0.contentInset = UIEdgeInsets(top: 0, left: 16.0, bottom: 0, right: 16.0)
        $0.allowsMultipleSelection = true
        $0.register(ExhibitFilterTypeCell.self,
                    forCellWithReuseIdentifier: ExhibitFilterTypeCell.identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.Background.darkGray02
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(typeLabel: String){
        self.filterTypeLabel.text = typeLabel
    }
    
    func setUI(){
        self.addSubview(filterTypeLabel)
        self.addSubview(collectionView)
        
        filterTypeLabel.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16.0)
            $0.top.equalTo(self.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(filterTypeLabel.snp.bottom)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(76.0)
        }
    }

}

extension ExhibitFilterContainerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExhibitFilterTypeCell.identifier, for: indexPath) as? ExhibitFilterTypeCell else {
            return UICollectionViewCell()
        }
        cell.config(type: filterItem[indexPath.row])
        
        return cell
    }
    
    
}

extension ExhibitFilterContainerView: UICollectionViewDelegateFlowLayout{
    // cell의 width, height 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return ExhibitFilterTypeCell.fittingSize(availableHeight: ExhibitFilterTypeCell.height,
                                                 name: filterItem[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16.0, bottom: 8, right: 16.0)
    }
}


extension ExhibitFilterContainerView: UICollectionViewDelegate {
    
}
