//
//  ExhibitConfirmViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class ExhibitConfirmViewController: UIViewController {
    //MARK: - Properties
    var currentExhibit: Exhibit?
    let viewModel = ExhibitConfirmViewModel()
    
    //MARK: - UI Components
    let exhibitTypeLabel = UILabel().then{
        $0.text = "Current Exhibition"
        $0.font = UIFont.TTFont(type: .MontMed, size: 13)
        $0.textColor = UIColor.Point.or01
    }
    
    let alertTitleLabel = UILabel().then{
        $0.text = "예매가 완료되었습니다."
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = .white
    }
    
    let stickView = UIView().then{
        $0.backgroundColor = UIColor.Point.or01
    }
    
    let buyerLabel = UILabel().then{
        $0.text = "인터파크"
        $0.font = UIFont.TTFont(type: .SDMed, size: 11)
        $0.textColor = .white
    }
    
    let exhibitTitleLabel = UILabel().then{
        $0.text = "짱구페스티벌 짱구야 캠핑가자"
        $0.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.textColor = UIColor.Point.or01
        $0.numberOfLines = 0
    }
    
    let dateLabel = UILabel().then{
        $0.text = "2021.10.20 ~ 2022.03.20"
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = .white
    }
    
    let locationLabel = UILabel().then{
        $0.text = "용산 아이파크몰 ~"
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = .white
    }
    
    let priceLabel = UILabel().then{
        $0.text = "13000원"
        $0.font = UIFont.TTFont(type: .MontSemiBold, size: 11)
        $0.textColor = .white
    }
    
    let exhibitImageView = UIImageView().then{
        $0.contentMode = .top
        $0.clipsToBounds = true
    }
    
    lazy var backBtn = UIButton().then{
        $0.setTitle("돌아가기", for: .normal)
        $0.backgroundColor = UIColor.Basic.gray01
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(backBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var completeBtn = UIButton().then{
        $0.setTitle("예매 완료", for: .normal)
        $0.backgroundColor = UIColor.Point.or01
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(completeBtnPressed(_:)), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        setUI()
        config()
        setNavigationItem()
    }
    
    //MARK: - Functions
    @objc func completeBtnPressed(_ sender: UIButton){
        //TODO: root  VC 로 가자
        self.viewModel.requestReserve(exhbt_cd: self.currentExhibit?.exhbt_cd ?? "")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func backBtnPressed(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func config(){
        guard let currentExhibit = self.currentExhibit else { return }
        exhibitTitleLabel.text = currentExhibit.exhbt_nm
        dateLabel.text = "\(currentExhibit.exhbt_from_dt ?? "") ~ \(currentExhibit.exhbt_to_dt ?? "")"
        locationLabel.text = currentExhibit.exhbt_lct
        if let dc_prc = currentExhibit.dc_prc{
            priceLabel.text = dc_prc
        }else{
            priceLabel.text = currentExhibit.exhbt_prc
        }
        
        exhibitImageView.kf.setImage(with: URL(string: currentExhibit.exhbt_sn ?? "")){ result in
            switch result{
            case .success:
                self.exhibitImageView.image = self.exhibitImageView.image?.resize(newWidth: 167.0)
            case .failure(let error):
                print("error -> \(error.localizedDescription)")
            }
        }
    }
    
    func setNavigationItem(){
        self.navigationItem.title = "예매확인"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func setUI(){
        self.view.addSubview(exhibitTypeLabel)
        self.view.addSubview(alertTitleLabel)
        self.view.addSubview(stickView)
        self.view.addSubview(buyerLabel)
        self.view.addSubview(exhibitTitleLabel)
        self.view.addSubview(dateLabel)
        self.view.addSubview(locationLabel)
        self.view.addSubview(priceLabel)
        self.view.addSubview(exhibitImageView)
        self.view.addSubview(backBtn)
        self.view.addSubview(completeBtn)
        
        exhibitTypeLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(110.0)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(32.0)
        }
        
        alertTitleLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitTypeLabel.snp.bottom).offset(7.0)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(32.0)
        }
        
        stickView.snp.makeConstraints{
            $0.top.equalTo(alertTitleLabel.snp.bottom).offset(12.0)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(32.0)
            $0.height.equalTo(3.0)
        }
        
        exhibitImageView.snp.makeConstraints{
            $0.top.equalTo(stickView.snp.bottom).offset(16.0)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-32.0)
            $0.width.height.equalTo(167.0)
        }
        
        buyerLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitImageView.snp.top)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(32.0)
        }
        
        exhibitTitleLabel.snp.makeConstraints{
            $0.top.equalTo(buyerLabel.snp.bottom).offset(5.0)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(32.0)
            $0.trailing.equalTo(exhibitImageView.snp.leading).offset(-6.0)
        }
        
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitTitleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(32.0)
            $0.trailing.equalTo(exhibitImageView.snp.leading).offset(-6.0)
        }
        
        locationLabel.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(32.0)
            $0.trailing.equalTo(exhibitImageView.snp.leading).offset(-6.0)
        }
        
        priceLabel.snp.makeConstraints{
            $0.bottom.equalTo(exhibitImageView.snp.bottom)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(32.0)
        }
        
        backBtn.snp.makeConstraints{
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(32.0)
            $0.trailing.equalTo(completeBtn.snp.leading).offset(-16.0)
            $0.bottom.equalToSuperview().offset(-64.0)
            $0.width.equalTo(completeBtn.snp.width)
            $0.height.equalTo(48.0)
        }
        
        completeBtn.snp.makeConstraints{
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-32.0)
            $0.bottom.equalToSuperview().offset(-64.0)
            $0.height.equalTo(48.0)
        }
    }
}
