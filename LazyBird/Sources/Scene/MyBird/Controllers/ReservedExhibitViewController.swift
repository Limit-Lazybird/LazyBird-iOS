//
//  ReservedExhibitViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit
import SnapKit
import Then


class ReservedExhibitViewController: UIViewController {
    //MARK: - Properties
    var viewModel: MyBirdViewModel?
    
    //MARK: - UI Components
    let reservedLabel = UILabel().then{
        $0.text = "예매한 전시"
        $0.font = UIFont.TTFont(type: .SDBold, size: 24)
        $0.textColor = .white
    }
    
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
        $0.register(ReservedCell.self, forCellWithReuseIdentifier: ReservedCell.identifier)
    }
    
    let noResultLabel = UILabel().then{
        $0.text = "에매한 전시가 없어요."
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.Basic.gray03
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        setUI()
        config()
    }
    
    //MARK: - Functions
    func config(){
        guard let viewModel = self.viewModel else {
            print("ReservedExhibitViewController is nil")
            return
        }
        
        viewModel.favoriteExhibits.bind { exhibits in
            print("Reserved bind 호출")
            self.collectionView.reloadData()
            
            if exhibits.count == 0{
                self.noResultLabel.isHidden = false
            }else{
                self.noResultLabel.isHidden = true
            }
        }
    }
    
    func setUI(){
        self.view.addSubview(reservedLabel)
        self.view.addSubview(noResultLabel)
        
        reservedLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(24.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        noResultLabel.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

extension ReservedExhibitViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else {
            print("FavoriteExhibitDetailViewController is nil")
            return 0
        }
        
        return viewModel.reservationExhibits.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReservedCell.identifier, for: indexPath) as? ReservedCell else{
            return UICollectionViewCell()
        }
        
        guard let viewModel = self.viewModel else {
            print("FavoriteExhibitDetailViewController is nil")
            return UICollectionViewCell()
        }
        
        cell.config(exhibit: viewModel.reservationExhibits.value[indexPath.row])
        
        return cell
    }
    
    
}

extension ReservedExhibitViewController: UICollectionViewDelegate{
    
}

extension ReservedExhibitViewController: UICollectionViewDelegateFlowLayout {

    // cell의 width, height 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 16) / 2
        let height: CGFloat = width * 0.5730994152
        
        return CGSize(width: width, height: height)
    }
}
