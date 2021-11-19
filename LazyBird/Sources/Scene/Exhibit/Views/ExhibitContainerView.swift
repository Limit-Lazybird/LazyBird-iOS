//
//  ExhibitContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/15.
//

import UIKit

class ExhibitContainerView: UIView {
    //MARK: - Properties
    
    var delegate: ExhibitViewDelegate?
    var viewModel: ExhibitViewModel?
    
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
        self.backgroundColor = UIColor.Background.black02
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func config(viewModel: ExhibitViewModel){
        self.viewModel = viewModel
        guard let vm = self.viewModel else { return }
        
        vm.getExhibits().bind { exhibits in
            print("bind 호출됨")
            self.collectionView.reloadData()
        }
        
        vm.fetchExhibits()
    }
    
    func setUI(){
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
}

extension ExhibitContainerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else {
            print("ExhibitViewModel is nil")
            return 0
        }
        return viewModel.exhibits.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExhibitCell.identifier, for: indexPath) as? ExhibitCell else {
            return UICollectionViewCell()
        }
        guard let viewModel = self.viewModel else {
            print("ExhibitViewModel is nil")
            return UICollectionViewCell()
        }
        cell.config(exhibit: viewModel.exhibits.value[indexPath.row])
        
        return cell
    }
    
    
}
extension ExhibitContainerView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.moveToDetailView(indexPath: indexPath)
    }
}

extension ExhibitContainerView: UICollectionViewDelegateFlowLayout {

    // cell의 width, height 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 48) / 2
        let height: CGFloat = (collectionView.frame.height - 32) / 2
        
        return CGSize(width: width, height: height)
    }
}
