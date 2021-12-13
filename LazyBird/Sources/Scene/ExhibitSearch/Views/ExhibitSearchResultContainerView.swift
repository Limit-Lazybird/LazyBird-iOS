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
    
    lazy var noResultView = UIView().then{
        $0.backgroundColor = .clear
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(emptyViewTapped(_:))))
    }
    
    let noResultLabel = UILabel().then{
        $0.text = "검색 결과가 존재하지 않습니다."
        $0.textColor = UIColor.Basic.gray03
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
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
    @objc func emptyViewTapped(_ sender: Any){
        self.delegate?.willEndEditing()
    }
    
    func config(viewModel: ExhibitSearchViewModel){
        //TODO: 데이터 바인딩 (in CollectionView)
        self.viewModel = viewModel
        
        viewModel.exhibits.bind { searchedExhibits in
            print("bind 호출됨")
            if self.viewModel?.exhibits.value.count == 0{
                //TODO: 검색결과 없음
                self.noResultView.isHidden = false
                self.collectionView.isHidden = true
            }else{
                //TODO: 검색결과 있음
                self.noResultView.isHidden = true
                self.collectionView.isHidden = false
            }
            self.collectionView.reloadData()
        }
    }
    
    func setUI(){
        self.addSubview(collectionView)
        self.addSubview(noResultView)
        noResultView.addSubview(noResultLabel)
        
        noResultView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        noResultLabel.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

extension ExhibitSearchResultContainerView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else {
            print("viewModel is nil")
            return 0
        }
        return viewModel.getExhibits().value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExhibitCell.identifier, for: indexPath) as? ExhibitCell else {
            return UICollectionViewCell()
        }
        guard let viewModel = self.viewModel else {
            print("ExhibitSearchViewModel is nil")
            return UICollectionViewCell()
        }
        
        cell.config(exhibit: viewModel.exhibits.value[indexPath.row])
        
        return cell
    }
}

extension ExhibitSearchResultContainerView: UIScrollViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.delegate?.willEndEditing()
    }
}

extension ExhibitSearchResultContainerView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("터치됨~~~")
        self.delegate?.moveToDetail(indexPath: indexPath)
    }
}

extension ExhibitSearchResultContainerView: UICollectionViewDelegateFlowLayout {

    // cell의 width, height 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 48) / 2
        let height: CGFloat = (collectionView.frame.height - 32) / 2
        
        return CGSize(width: width, height: height)
    }
}
