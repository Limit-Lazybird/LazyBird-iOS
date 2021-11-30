//
//  EarlyBirdDetailViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/10.
//

import UIKit
import SnapKit
import Then

protocol ExhibitDetailViewControllerDelegate{
    func moveToNotice() // 예매 공지 화면으로 이동
}

class ExhibitDetailViewController: UIViewController {
    
    //MARK: - Properties
    var exhibitDetailViewModel = ExhibitDetailViewModel()
    
    //MARK: - UI Components
    private let scrollView = UIScrollView().then{
        $0.contentInsetAdjustmentBehavior = .never
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    
    lazy var backBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(back(_:))).then{
        $0.image = UIImage(systemName: "ic_arrow")
        $0.tintColor = .white
    }
    
    let exhibitImageContainerView = ExhibitImageContainerView(frame: .zero)
    let exhibitInfoContainerView = ExhibitInfoContainerView(frame: .zero)
    let exhibitGuideContainerView = ExhibitGuideContainerView(frame: .zero)
    let exhibitContentContainerView = ExhibitContentContainerView(frame: .zero)
    lazy var bookContainerView = TicketBookContainerView(frame: .zero).then {
        $0.delegate = self
    }
    
    
    lazy var stackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 0.0
        $0.backgroundColor = .white
        $0.addArrangedSubview(exhibitImageContainerView)
        $0.addArrangedSubview(exhibitInfoContainerView)
        $0.addArrangedSubview(SeparatorView(frame: .zero))
        $0.addArrangedSubview(exhibitContentContainerView)
        $0.addArrangedSubview(SeparatorView(frame: .zero))
        $0.addArrangedSubview(exhibitGuideContainerView)
    }

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        print("vc viewdidload")
     
        setNavigationItem()
        setUI()
        
        setConfigure()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Functions
    
    @objc func back(_ sender: UIButton){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    func setNavigationItem(){
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.Background.black02
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    func setConfigure(){
        exhibitImageContainerView.config(viewModel: self.exhibitDetailViewModel)
        exhibitInfoContainerView.config(viewModel: self.exhibitDetailViewModel)
        exhibitGuideContainerView.config(viewModel: self.exhibitDetailViewModel)
        exhibitContentContainerView.config(viewModel: self.exhibitDetailViewModel, frame: self.view.frame)
    }
    
    func setUI(){
        self.view.addSubview(scrollView)
        self.view.addSubview(bookContainerView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        scrollView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(bookContainerView.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        bookContainerView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(86.0)
        }
    }
}

extension ExhibitDetailViewController: ExhibitDetailViewControllerDelegate{
    func moveToNotice() {
        let exhibitNoticeVC = ExhibitNoticeViewController()
        exhibitNoticeVC.currentExhibit = exhibitDetailViewModel.getExhibit().value
        
        self.navigationController?.pushViewController(exhibitNoticeVC, animated: true)
    }
}
