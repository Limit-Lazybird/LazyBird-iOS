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
    var viewModel: ExhibitViewModel?
    
    var dummyCategory: [String] = ["회화","조형","사진","특별전","체험전","아동전시"]
    
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
        $0.allowsMultipleSelection = true
        $0.contentInset = UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 0)
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    
    lazy var filterBtn = UIButton().then{
        $0.setImage(UIImage(named: "filter"), for: .normal)
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.layer.cornerRadius = 26 / 2
        $0.addTarget(self, action: #selector(filterBtnPressed(_:)), for: .touchUpInside)
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
    
    @objc func filterBtnPressed(_ sender: UIButton){
        //TODO: 여기할거 까먹지말자!
        delegate?.moveToExhibitFilter()
    }
    
    func setUI(){
        self.addSubview(collectionView)
        self.addSubview(filterBtn)
        
        filterBtn.snp.makeConstraints{
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16.0)
            $0.width.equalTo(53.0)
        }
        
        collectionView.snp.makeConstraints{
            $0.leading.equalTo(filterBtn.snp.trailing).offset(8.0)
            $0.top.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

extension CategoryContainerView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: 1. 서버에서 필터링 해줄건지?
        // TODO: 2. 그냥 전체 리스트를 받아와서 내가 스스로 필터링을 할건지?? <- 아마 이 방법으로 하지 않을까 싶다
        let category = String(indexPath.row + 1)
        print("호출되나?")
        self.viewModel?.requestCategoryFilteredExhibits(category: category)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //TODO: 원래 리스트로 돌아오기
        self.viewModel?.fetchExhibits()
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
}
