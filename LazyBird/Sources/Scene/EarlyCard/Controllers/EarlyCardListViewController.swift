//
//  EarlyCardListViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/14.
//

import UIKit
import SnapKit
import Then

class EarlyCardListViewController: UIViewController {
    //MARK: - Properties
    let viewModel = EarlyCardViewModel()
    
    //MARK: - UI Components
    let alertLabel = UILabel().then{
        $0.text = "Early\nCard"
        $0.numberOfLines = 0
        $0.font = UIFont.TTFont(type: .MontBold, size: 40)
        $0.textColor = UIColor.Point.or01
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
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 16.0, bottom: 16.0, right: 16.0)
        $0.register(EarlyCardCell.self, forCellWithReuseIdentifier: EarlyCardCell.identifier)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        setUI()
        setBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.viewModel.requestEarlyCardList()
    }
    
    //MARK: - Functions
    func setBind(){
        self.viewModel.earlyCards.bind { cards in
            print("early card bind called")
            self.collectionView.reloadData()
        }
    }
    
    func setUI(){
        self.view.addSubview(alertLabel)
        self.view.addSubview(collectionView)
        
        alertLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(32.0)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(24.0)
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(alertLabel.snp.bottom)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

extension EarlyCardListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.earlyCards.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EarlyCardCell.identifier, for: indexPath) as? EarlyCardCell else{
            return UICollectionViewCell()
        }
        
        cell.config(card: self.viewModel.earlyCards.value[indexPath.row],
                    count: self.viewModel.earlyCards.value[indexPath.row].early_num,
                    newWidth: cell.frame.width - 22.0)
        
        return cell
    }
}

extension EarlyCardListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: 디테일 화면으로 넘어가자
        let earlyCardDetailVC = EarlyCardDetailViewController()
        earlyCardDetailVC.currentCard = self.viewModel.earlyCards.value[indexPath.row]
        earlyCardDetailVC.modalPresentationStyle = .overFullScreen
        
        self.present(earlyCardDetailVC, animated: true, completion: nil)
    }
}

extension EarlyCardListViewController: UICollectionViewDelegateFlowLayout {

    // cell의 width, height 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 48) / 2
        let height: CGFloat = (collectionView.frame.height - 32) / 2
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0.0, bottom: 16, right: 0.0)
    }
}
