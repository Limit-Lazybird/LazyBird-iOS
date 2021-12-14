//
//  ReservedExhibitViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit
import SnapKit
import Then


protocol ReservedExhibitViewControllerDelegate{
    func checkReseredExhibitionDeleteAlert(exhbt_cd: String) // 전시회 삭제할건지 물어보는 alert
}

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
        setNavigationItem()
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let viewModel = self.viewModel else {
            print("FavoriteExhibitDetailViewController viewmodel is nil")
            return
        }
        
        viewModel.requestReservationExhibits()
    }
    
    //MARK: - Functions
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
            print("ReservedExhibitViewController is nil")
            return
        }
        
        viewModel.reservationExhibits.bind { exhibits in
            print("Reserved bind 호출")
            self.collectionView.reloadData()
            
            if self.viewModel?.reservationExhibits.value.count == 0{
                self.noResultLabel.isHidden = false
            }else{
                self.noResultLabel.isHidden = true
            }
        }
    }
    
    func setNavigationItem(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    func setUI(){
        self.view.addSubview(reservedLabel)
        self.view.addSubview(noResultLabel)
        self.view.addSubview(collectionView)
        
        reservedLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(24.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        noResultLabel.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(reservedLabel.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func checkAlert(exhbt_cd: String){
        let alert = UIAlertController(title: "전시회 삭제", message: "해당 전시회를 삭제하실건가요?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { (ok) in
            //TODO: 삭제 api 부르면 될듯?
            self.viewModel?.requestReservedExhibitionRemove(exhbt_cd: exhbt_cd){
                //TODO: 삭제 완료후 alert 띄우고, tableView data reload
                self.completeAlert()
                self.viewModel?.requestReservationExhibits()
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { cancels in
            //TODO: 취소니까 아무 작동안해도됨
        }

        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func completeAlert(){
        let alert = UIAlertController(title: "삭제 완료", message: "삭제가 완료되었습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)

        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
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
        
        cell.delegate = self
        cell.config(exhibit: viewModel.reservationExhibits.value[indexPath.row])
        
        return cell
    }
}

extension ReservedExhibitViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: moveToDetail
        guard let viewModel = self.viewModel else {
            print("FavoriteExhibitDetailViewController collectionView didSelectItemAt viewModel is nil")
            return
        }
        
        let exhibitDetailVC = ExhibitDetailViewController()
        exhibitDetailVC.hidesBottomBarWhenPushed = true
        exhibitDetailVC.exhibitDetailViewModel.setExhibit(viewModel.reservationExhibits.value[indexPath.row])
        self.navigationController?.pushViewController(exhibitDetailVC, animated: true)
    }
}

extension ReservedExhibitViewController: UICollectionViewDelegateFlowLayout {

    // cell의 width, height 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 32) 
        let height: CGFloat = width * 0.5730994152
        
        return CGSize(width: width, height: height)
    }
}

extension ReservedExhibitViewController: ReservedExhibitViewControllerDelegate{
    /* 전시회 삭제할건지 물어보는 alert */
    func checkReseredExhibitionDeleteAlert(exhbt_cd: String){
        //TODO: 지울건지 안지울건지 여부
        self.checkAlert(exhbt_cd: exhbt_cd)
    }
}
