//
//  ExhibitSearchResultContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit

class ExhibitSearchResultContainerView: UIView {
    //MARK: - Properties
    var delegate: ExhibitSearchViewControllerDelegate?
    var viewModel: ExhibitSearchViewModel?
    
    //MARK: - UI Components
    
    private let layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = .zero
        $0.minimumInteritemSpacing = 16
        $0.minimumLineSpacing = 16
    }
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then{
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 16.0, bottom: 16.0, right: 16.0)
        $0.register(ExhibitCell.self, forCellWithReuseIdentifier: ExhibitCell.identifier)
    }
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    func config(viewModel: ExhibitSearchViewModel){
        //TODO: 여기서 아이템 바인딩해야할듯
    }
    
    func setUI(){
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

extension ExhibitSearchResultContainerView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

extension ExhibitSearchResultContainerView: UICollectionViewDelegate{
    
}

extension ExhibitSearchResultContainerView: UICollectionViewDelegateFlowLayout {

    // cell의 width, height 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 48) / 2
        let height: CGFloat = (collectionView.frame.height - 32) / 2
        
        return CGSize(width: width, height: height)
    }
}
