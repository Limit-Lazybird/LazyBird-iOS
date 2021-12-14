//
//  ReservedExhibitDetailViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit
import SnapKit
import Then

class FavoriteExhibitDetailViewController: UIViewController {
    //MARK: - Properties
    var viewModel: MyBirdViewModel?
    
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
    
    let favoriteLabel = UILabel().then{
        $0.text = "찜한 전시"
        $0.font = UIFont.TTFont(type: .SDBold, size: 24)
        $0.textColor = .white
    }
    
    //TODO: 이따 collectionView fetch할때 같이 수정하자
    let noResultLabel = UILabel().then{
        $0.text = "찜한 전시가 없어요."
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.Basic.gray03
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        setUI()
        config()
        setObserver()
        setNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        checkExhibit()
    }
    
    //MARK: - Functions
    @objc func likePressedNotification(_ noti: Notification){
        print("TODO: 컬렉션뷰 reload")
        self.viewModel?.requestFavoriteExhibits()
    }
    
    func setNavigationItem(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    func setObserver(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(likePressedNotification(_:)),
                                               name: NSNotification.Name("likePressedNotification"),
                                               object: nil)
    }
    
    func checkExhibit(){
        guard let viewModel = self.viewModel else {
            print("FavoriteExhibitDetailViewController is nil")
            return
        }
        if viewModel.favoriteExhibits.value.count == 0{
            self.noResultLabel.isHidden = false
        }else{
            self.noResultLabel.isHidden = true
        }
    }
    
    func config(){
        guard let viewModel = self.viewModel else {
            print("FavoriteExhibitDetailViewController is nil")
            return
        }
        
        viewModel.favoriteExhibits.bind { exhibits in
            print("favorite bind 호출")
            if viewModel.favoriteExhibits.value.count == 0{
                self.noResultLabel.isHidden = false
            }else{
                self.noResultLabel.isHidden = true
            }
            self.collectionView.reloadData()
        }
    }
    
    func setUI(){
        self.view.addSubview(favoriteLabel)
        self.view.addSubview(noResultLabel)
        self.view.addSubview(collectionView)
        
        favoriteLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(24.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(favoriteLabel.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        noResultLabel.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

extension FavoriteExhibitDetailViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else {
            print("FavoriteExhibitDetailViewController is nil")
            return 0
        }
        print("count _-------> \(viewModel.favoriteExhibits.value.count)")
        return viewModel.favoriteExhibits.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExhibitCell.identifier, for: indexPath) as? ExhibitCell else{
            return UICollectionViewCell()
        }
        
        guard let viewModel = self.viewModel else {
            print("FavoriteExhibitDetailViewController is nil")
            return UICollectionViewCell()
        }
        print("favorite --> \(viewModel.favoriteExhibits.value[indexPath.row])")
        cell.config(exhibit: viewModel.favoriteExhibits.value[indexPath.row])
        
        return cell
    }
}

extension FavoriteExhibitDetailViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: moveToDetail
        guard let viewModel = self.viewModel else {
            print("FavoriteExhibitDetailViewController collectionView didSelectItemAt viewModel is nil")
            return
        }
        let exhibitDetailVC = ExhibitDetailViewController()
        exhibitDetailVC.hidesBottomBarWhenPushed = true
        exhibitDetailVC.exhibitDetailViewModel.setExhibit(viewModel.favoriteExhibits.value[indexPath.row])
        self.navigationController?.pushViewController(exhibitDetailVC, animated: true)
    }
}

extension FavoriteExhibitDetailViewController: UICollectionViewDelegateFlowLayout {

    // cell의 width, height 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 48) / 2
        let height: CGFloat = (collectionView.frame.height - 32) / 2
        
        return CGSize(width: width, height: height)
    }
}
