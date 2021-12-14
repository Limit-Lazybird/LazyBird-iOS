//
//  ExhibitFilterViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/15.
//

import UIKit
import SnapKit
import Then

enum categotyType{
    case classification
    case additionalInformation
    case region
}

class ExhibitFilterViewController: UIViewController {
    //MARK: - Properties
    let viewModel = ExhibitFilterViewModel()
    var delegate: ExhibitViewDelegate?
    
    //MARK: - UI Components
    lazy var bgView = UIView().then{
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(emptyViewTapped(_:))))
    }
    
    let contentView = UIView().then{
        $0.backgroundColor = UIColor.Background.darkGray02
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 20
    }
    
    let titleLabel = UILabel().then{
        $0.text = "전시회 상세 검색"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = .white
    }
    
    lazy var refreshBtn = UIButton().then{
        $0.setImage(UIImage(named: "refresh"), for: .normal)
        $0.addTarget(self, action: #selector(refreshBtnTapped(_:)), for: .touchUpInside)
    }
    
    lazy var exhibitClassView = ExhibitFilterContainerView(frame: .zero).then{
        $0.config(typeLabel: "전시 분류")
        $0.viewModel = self.viewModel
        $0.categoryType = .classification
        $0.filterItem.append(contentsOf: ["회화","조형","사진","특별전","체험전","아동전시"])
    }
    
    lazy var exhibitAdditionalInfomationView = ExhibitFilterContainerView(frame: .zero).then{
        $0.config(typeLabel: "전시 부가 정보")
        $0.viewModel = self.viewModel
        $0.categoryType = .additionalInformation
        $0.filterItem.append(contentsOf: ["사진 촬영 가능", "주차공간 제공", "오디오 제공", "무료", "온라인 관람", "공휴일 운영", "18시 이후 운영"])
    }
    
    lazy var exhibitRegionView = ExhibitFilterContainerView(frame: .zero).then{
        $0.config(typeLabel: "지역")
        $0.viewModel = self.viewModel
        $0.categoryType = .region
        $0.filterItem.append(contentsOf: ["서울", "경기•인천", "강원", "부산•울산•경남", "대구•경북", "광주•전라", "대전•충청•세종", "제주"])
    }
    
    lazy var closeBtn = UIButton().then{
        $0.backgroundColor = UIColor.Basic.gray02
        $0.setTitle("닫기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 15)
        $0.addTarget(self, action: #selector(closeBtnTapped(_:)), for: .touchUpInside)
    }
    
    lazy var applyBtn = UIButton().then{
        $0.backgroundColor = UIColor.Point.or01
        $0.setTitle("적용하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.addTarget(self, action: #selector(applyBtnTapped(_:)), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        setUI()
    }
    
    //MARK: - Functions
    @objc func refreshBtnTapped(_ sender: UIButton){
        //TODO: 3개의 컬렉션뷰 선택 해제, 선택되었던 정보들 초기화
        exhibitClassView.deselectAllCategory()
        exhibitAdditionalInfomationView.deselectAllCategory()
        exhibitRegionView.deselectAllCategory()
        
        self.viewModel.removeDeselectedAllCategory()
    }
    
    @objc func closeBtnTapped(_ sender: UIButton){
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func applyBtnTapped(_ sender: UIButton){
        //TODO: 필터 적용 여기서 request // 이 밑에 카테고리로 request하자. 일단은 테스트 ㄱ
        
        viewModel.requestExhibitDTL(){ response in
            //TODO: exhibit 리스트 수정하자
            print("여ㄷ긴 들어옹나???")
            self.delegate?.updateFilteredExhibit(filteredExhibit: response)
            self.dismiss(animated: false, completion: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func emptyViewTapped(_ sender: Any){
        self.dismiss(animated: false, completion: nil)
    }
    
    func setUI(){
        self.view.addSubview(bgView)
        self.view.addSubview(contentView)
        contentView.addSubview(closeBtn)
        contentView.addSubview(applyBtn)
        contentView.addSubview(titleLabel)
        contentView.addSubview(refreshBtn)
        contentView.addSubview(exhibitClassView)
        contentView.addSubview(exhibitAdditionalInfomationView)
        contentView.addSubview(exhibitRegionView)
        
        bgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(470.0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24.0)
            $0.centerX.equalToSuperview()
        }
        
        refreshBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(23.0)
            $0.trailing.equalToSuperview().offset(-35.0)
            $0.width.height.equalTo(24.0)
        }
        
        exhibitClassView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(10.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(95.0)
        }
        
        exhibitAdditionalInfomationView.snp.makeConstraints{
            $0.top.equalTo(exhibitClassView.snp.bottom).offset(10.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(95.0)
        }
        
        exhibitRegionView.snp.makeConstraints{
            $0.top.equalTo(exhibitAdditionalInfomationView.snp.bottom).offset(10.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(95.0)
        }
        
        closeBtn.snp.makeConstraints{
            $0.leading.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.equalTo(130.0)
            $0.height.equalTo(54.0)
        }
        
        applyBtn.snp.makeConstraints{
            $0.leading.equalTo(closeBtn.snp.trailing)
            $0.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(54.0)
        }
    }
}

