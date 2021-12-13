//
//  TakeEarlyCardViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/14.
//

// self.navigationController?.popToRootViewController(animated: true)

import UIKit
import SnapKit
import Then
import Kingfisher

class TakeEarlyCardViewController: UIViewController {
    //MARK: - Properties
    var bookedExhibition: Exhibit?
    let viewModel = EarlyCardViewModel()
    
    //MARK: - UI Components
    let alertLabel = UILabel().then{
        $0.text = "Take Your\nEarlycard"
        $0.numberOfLines = 0
        $0.font = UIFont.TTFont(type: .MontBold, size: 40)
        $0.textColor = UIColor.Point.or01
    }
    
    let cardBgView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 18.0
    }
    
    let thumbnailImageView = UIImageView().then{
        $0.contentMode = .top
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 18.0
    }
    
    let circleView = UIView().then{
        $0.backgroundColor = UIColor.Background.black02
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 48 / 2
    }
    
    let circleViewTwo = UIView().then{
        $0.backgroundColor = UIColor.Background.black02
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 48 / 2
    }
    
    let dashLineImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.image = UIImage(named: "dash_line")
    }
    
    let numberLabel = UILabel().then{
        $0.text = "NO.X"
        $0.font = UIFont.TTFont(type: .MontBold, size: 18)
        $0.textColor = UIColor.Point.or01
    }
    
    let exhibitTitleLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.Background.black02
    }
    
    let visitAlertLabel = UILabel().then{
        $0.text = "관람  -"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.Background.black02
    }
    
    lazy var completeBtn = UIButton().then{
        $0.setTitle("", for: .normal)
        $0.backgroundColor = UIColor.Point.or01.withAlphaComponent(0.8)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(completeBtnPressed(_:)), for: .touchUpInside)
    }
    
    let btnLabel = UILabel().then{
        $0.text = "얼리카드가 추가되었어요"
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.textColor = .white
    }
    
    let btnLabelTwo = UILabel().then{
        $0.text = "보러가기"
        $0.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.textColor = .white
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
        
        self.viewModel.requestEarlyCardListForCount()
    }
    
    //MARK: - Functions
    @objc func completeBtnPressed(_ sender: UIButton){
        self.dismiss(animated: true) {
            //TODO: 화면 닫고, 얼리카드 리스트 페이지로 이동
            print("화면 닫고, 얼리카드 리스트 페이지로 이동")
        }
    }
    
    func setBind(){
        guard let bookedExhibition = self.bookedExhibition else{
            print("TakeEarlyCardViewController setBind bookedExhibition is nil")
            return
        }
        
        self.viewModel.cardCount.bind { count in
            self.numberLabel.text = "NO.\(count)"
        }
        
        exhibitTitleLabel.text = bookedExhibition.exhbt_nm
        
        thumbnailImageView.kf.setImage(with: URL(string: bookedExhibition.exhbt_sn ?? "")){ result in
            switch result{
            case .success:
                let newWidth: CGFloat = self.view.frame.width - (48.0 * 2) - (21.0 * 2)
                self.thumbnailImageView.image = self.thumbnailImageView.image?.resize(newWidth: newWidth)
            case .failure(let error):
                print("error -> \(error.localizedDescription)")
            }
        }
    }
    
    func setUI(){
        self.view.addSubview(alertLabel)
        self.view.addSubview(cardBgView)
        self.view.addSubview(completeBtn)
        self.view.addSubview(btnLabel)
        self.view.addSubview(btnLabelTwo)
        cardBgView.addSubview(thumbnailImageView)
        cardBgView.addSubview(circleView)
        cardBgView.addSubview(circleViewTwo)
        cardBgView.addSubview(dashLineImageView)
        cardBgView.addSubview(numberLabel)
        cardBgView.addSubview(exhibitTitleLabel)
        cardBgView.addSubview(visitAlertLabel)
        
        alertLabel.snp.makeConstraints{
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(48.0)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(60.0)
        }
        
        cardBgView.snp.makeConstraints{
            $0.top.equalTo(alertLabel.snp.bottom).offset(32.0)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(48.0)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-48.0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-30.0)
        }
        
        thumbnailImageView.snp.makeConstraints{
            $0.top.equalTo(cardBgView.snp.top).offset(21.0)
            $0.leading.equalTo(cardBgView.snp.leading).offset(21.0)
            $0.trailing.equalTo(cardBgView.snp.trailing).offset(-21.0)
            $0.bottom.equalTo(dashLineImageView.snp.top).offset(-36.0)
        }
        
        circleView.snp.makeConstraints{
            $0.centerY.equalTo(cardBgView.snp.centerY).multipliedBy(1.4)
            $0.centerX.equalTo(cardBgView.snp.leading).offset(-4.0)
            $0.width.height.equalTo(48.0)
        }
        
        circleViewTwo.snp.makeConstraints{
            $0.centerY.equalTo(cardBgView.snp.centerY).multipliedBy(1.4)
            $0.centerX.equalTo(cardBgView.snp.trailing).offset(4.0)
            $0.width.height.equalTo(48.0)
        }
        
        dashLineImageView.snp.makeConstraints{
            $0.centerY.equalTo(circleView.snp.centerY)
            $0.leading.equalTo(circleView.snp.trailing).offset(18.0)
            $0.trailing.equalTo(circleViewTwo.snp.leading).offset(-18.0)
            $0.height.equalTo(5.0)
        }
        
        numberLabel.snp.makeConstraints{
            $0.top.equalTo(dashLineImageView.snp.bottom).offset(24.0)
            $0.leading.equalTo(cardBgView.snp.leading).offset(21.0)
        }
        
        exhibitTitleLabel.snp.makeConstraints{
            $0.top.equalTo(numberLabel.snp.bottom).offset(10.0)
            $0.leading.equalTo(cardBgView.snp.leading).offset(21.0)
        }
        
        visitAlertLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitTitleLabel.snp.bottom).offset(10.0)
            $0.leading.equalTo(cardBgView.snp.leading).offset(21.0)
        }
        
        btnLabel.snp.makeConstraints{
            $0.leading.equalTo(completeBtn.snp.leading).offset(16.0)
            $0.centerY.equalTo(completeBtn.snp.centerY)
        }
        
        btnLabelTwo.snp.makeConstraints{
            $0.trailing.equalTo(completeBtn.snp.trailing).offset(-16.0)
            $0.centerY.equalTo(completeBtn.snp.centerY)
        }
        
        completeBtn.snp.makeConstraints{
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16.0)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-16.0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-10.0)
            $0.height.equalTo(48.0)
        }
    }
}
