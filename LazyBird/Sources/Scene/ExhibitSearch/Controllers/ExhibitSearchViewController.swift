//
//  ExhibitSearchViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/24.
//

import UIKit
import SnapKit
import Then

protocol ExhibitSearchViewControllerDelegate{
    func moveToDetail(indexPath: IndexPath)  // detail view로 이동
    func willEndEditing() // end edit
}

class ExhibitSearchViewController: UIViewController {
    //MARK: - Properties
    let viewModel = ExhibitSearchViewModel()
    
    //MARK: - UI Components
    lazy var bgView = UIView().then{
        $0.backgroundColor = UIColor.Background.black02
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(emptyViewTapped(_:))))
    }
    
    let searchBarContainerView = UIView().then{
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.layer.cornerRadius = 38 / 2
    }
    
    let searchBarImageView = UIImageView().then{
        $0.image = UIImage(named: "ic_search_light")
        $0.contentMode = .scaleAspectFill
    }
    lazy var searchTextField = UITextField().then{
        $0.attributedPlaceholder = NSAttributedString(string: "검색할 전시회를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.Basic.gray04])
        $0.textColor = .white
        $0.delegate = self
    }
    
    let recommandLabel = UILabel().then{
        $0.text = "추천 검색어"
        $0.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.textColor = .white
    }
    
    lazy var recommandBtnOne = UIButton().then{
        $0.tag = 0
        $0.setTitle("회화", for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 4, right: 12)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.layer.cornerRadius = 26 / 2
        $0.addTarget(self, action: #selector(recommandBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var recommandBtnTwo = UIButton().then{
        $0.tag = 1
        $0.setTitle("조형", for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 4, right: 12)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.layer.cornerRadius = 26 / 2
        $0.addTarget(self, action: #selector(recommandBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var recommandBtnThree = UIButton().then{
        $0.tag = 2
        $0.setTitle("사진", for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 4, right: 12)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.layer.cornerRadius = 26 / 2
        $0.addTarget(self, action: #selector(recommandBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var recommandBtnFour = UIButton().then{
        $0.tag = 3
        $0.setTitle("특별전", for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 4, right: 12)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.layer.cornerRadius = 26 / 2
        $0.addTarget(self, action: #selector(recommandBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var recommandBtnFive = UIButton().then{
        $0.tag = 4
        $0.setTitle("아동전시", for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 4, right: 12)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.layer.cornerRadius = 26 / 2
        $0.addTarget(self, action: #selector(recommandBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var btnStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 4.0
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(recommandBtnOne)
        $0.addArrangedSubview(recommandBtnTwo)
        $0.addArrangedSubview(recommandBtnThree)
        $0.addArrangedSubview(recommandBtnFour)
        $0.addArrangedSubview(recommandBtnFive)
    }
    
    lazy var exhibitContainerView = ExhibitSearchResultContainerView().then{
        $0.delegate = self
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        setUI()
        setNavigationItem()
        setGesture()
        setConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
//        self.navigationController?.navigationBar.isHidden = false
    }
    //MARK: - Functions
    @objc func emptyViewTapped(_ sender: Any){
        print("터어어어치")
        self.view.endEditing(true)
    }
    
    @objc func recommandBtnPressed(_ sender: UIButton){
        print("버튼 눌리는 중")
        switch sender.tag {
        case 0:
            self.viewModel.fetchSearchedExhibit(word: "1")
            break
        case 1:
            self.viewModel.fetchSearchedExhibit(word: "2")
            break
        case 2:
            self.viewModel.fetchSearchedExhibit(word: "3")
            break
        case 3:
            self.viewModel.fetchSearchedExhibit(word: "4")
            break
        case 4:
            self.viewModel.fetchSearchedExhibit(word: "5")
            break
        default:
            print("잘못된 입력입니다.")
        }
    }
    
    @objc func swipeAction(_ sender :UISwipeGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func setNavigationItem(){
        self.navigationController?.navigationBar.isHidden = false
//        self.navigationItem.title = "검색"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    func setConfig(){
        self.exhibitContainerView.config(viewModel: self.viewModel)
    }
    
    func setGesture(){
        let leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        let rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        
        leftSwipeRecognizer.direction = .up
        rightSwipeRecognizer.direction = .down
        
        self.bgView.addGestureRecognizer(leftSwipeRecognizer)
        self.bgView.addGestureRecognizer(rightSwipeRecognizer)
    }
    
    func setUI(){
        self.view.addSubview(bgView)
        self.view.addSubview(searchBarContainerView)
        searchBarContainerView.addSubview(searchBarImageView)
        searchBarContainerView.addSubview(searchTextField)
        self.view.addSubview(recommandLabel)
        self.view.addSubview(btnStackView)
        self.view.addSubview(exhibitContainerView)
        
        bgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        searchBarContainerView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.height.equalTo(38.0)
        }
        
        searchBarImageView.snp.makeConstraints{
            $0.centerY.equalTo(searchBarContainerView.snp.centerY)
            $0.leading.equalToSuperview().offset(7.0)
            $0.width.height.equalTo(24.0)
        }
        
        searchTextField.snp.makeConstraints{
            $0.centerY.equalTo(searchBarContainerView.snp.centerY)
            $0.leading.equalTo(searchBarImageView.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().offset(-16.0)
        }
        
        recommandLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16.0)
            $0.top.equalTo(searchBarContainerView.snp.bottom).offset(24.0)
        }
        
        btnStackView.snp.makeConstraints{
            $0.top.equalTo(recommandLabel.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16.0)
        }
        
        exhibitContainerView.snp.makeConstraints{
            $0.top.equalTo(btnStackView.snp.bottom).offset(16.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        recommandBtnOne.snp.makeConstraints{
            $0.width.equalTo(47.0)
            $0.height.equalTo(26.0)
        }
        
        recommandBtnTwo.snp.makeConstraints{
            $0.width.equalTo(47.0)
            $0.height.equalTo(26.0)
        }
        
        recommandBtnThree.snp.makeConstraints{
            $0.width.equalTo(47.0)
            $0.height.equalTo(26.0)
        }
        
        recommandBtnFour.snp.makeConstraints{
            $0.width.equalTo(58.0)
            $0.height.equalTo(26.0)
        }
        
        recommandBtnFive.snp.makeConstraints{
            $0.width.equalTo(69.0)
            $0.height.equalTo(26.0)
        }
    }
}

extension ExhibitSearchViewController: ExhibitSearchViewControllerDelegate{
    func moveToDetail(indexPath: IndexPath) {
        //TODO: 디테일뷰로 이동 ⭐ 여기 응답 부분이 달라서 안됨 나중에 수정해야한다 ⭐
        let exhibitDetailVC = ExhibitDetailViewController()
        exhibitDetailVC.hidesBottomBarWhenPushed = true
        exhibitDetailVC.exhibitDetailViewModel.setExhibit(self.viewModel.getExhibits().value[indexPath.row])
        
        self.navigationController?.pushViewController(exhibitDetailVC, animated: true)
    }
    
    func willEndEditing(){
        self.view.endEditing(true)
    }
}

extension ExhibitSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //TODO: 검색 api 사용
        self.viewModel.fetchSearchedExhibit(word: textField.text ?? "")
        self.view.endEditing(true)
        return true
      }
}
