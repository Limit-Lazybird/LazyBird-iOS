//
//  ExhibitionVisitAlertViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/12.
//

import UIKit
import SnapKit
import Then

class ExhibitionVisitAlertViewController: UIViewController {
    //MARK: - Properties
    var currentSchedule: Schedule?
    var currentIndex: Int?
    var delegate: CalendarViewDelegate?
    
    //MARK: - UI Components
    lazy var bgView = UIView().then{
        $0.backgroundColor = UIColor.Opacity.black80
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(dismissBtnPressed(_:))))
    }
    
    let alertBgView = UIView().then{
        $0.backgroundColor = UIColor.Background.darkGray02
        $0.layer.cornerRadius = 10
    }
    
    let alertTitleLabel = UILabel().then{
        $0.text = "전시회는 잘 방문하셨나요?"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = .white
    }
    
    let alertContentLabel = UILabel().then{
        $0.text = "방문 확인을 하시면 캘린더에 표시됩니다."
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    lazy var cancelBtn = UIButton().then{
        $0.setTitle("아니오", for: .normal)
        $0.backgroundColor = UIColor.Basic.gray01
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(cancleBtnPressed), for: .touchUpInside)
    }
    
    lazy var completeBtn = UIButton().then{
        $0.setTitle("다녀왔어요", for: .normal)
        $0.backgroundColor = UIColor.Point.or01
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(completeBtnPressed), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        setUI()
    }
    
    //MARK: - Functions
    @objc func cancleBtnPressed(_ sender: UIButton){
        guard let delegate = delegate else {
            print("ExhibitionVisitAlertViewController cancleBtnPressed delegate is nil")
            return
        }

        //TODO: 전시회 방문 취소 처리
        delegate.cancelBtnPressed(currentSchedule: self.currentSchedule!,
                                  indexPath: self.currentIndex ?? 0)
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func completeBtnPressed(_ sender: UIButton){
        guard let delegate = delegate else {
            print("ExhibitionVisitAlertViewController completeBtnPressed delegate is nil")
            return
        }
        
        //TODO: 전시회 방문 처리
        delegate.completeBtnPressed(currentSchedule: self.currentSchedule!,
                                    indexPath: self.currentIndex ?? 0)
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func dismissBtnPressed(_ sender: UIButton){
        //TODO: 화면 dismiss
        self.dismiss(animated: false, completion: nil)
    }
    
    func setUI(){
        self.view.addSubview(bgView)
        self.view.addSubview(alertBgView)
        alertBgView.addSubview(alertTitleLabel)
        alertBgView.addSubview(alertContentLabel)
        alertBgView.addSubview(cancelBtn)
        alertBgView.addSubview(completeBtn)
        
        bgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        alertBgView.snp.makeConstraints{
            $0.centerY.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(42.0)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-42.0)
            $0.height.equalTo(165.0)
        }
        
        alertTitleLabel.snp.makeConstraints{
            $0.top.equalTo(alertBgView.snp.top).offset(20.0)
            $0.leading.equalTo(alertBgView.snp.leading).offset(20.0)
        }
        
        alertContentLabel.snp.makeConstraints{
            $0.top.equalTo(alertTitleLabel.snp.bottom).offset(12.0)
            $0.leading.equalTo(alertBgView.snp.leading).offset(20.0)
        }
        
        cancelBtn.snp.makeConstraints{
            $0.leading.equalTo(alertBgView.snp.leading).offset(20.0)
            $0.bottom.equalTo(alertBgView.snp.bottom).offset(-20.0)
            $0.trailing.equalTo(completeBtn.snp.leading).offset(-10.0)
            $0.height.equalTo(48.0)
        }
        
        completeBtn.snp.makeConstraints{
            $0.trailing.equalTo(alertBgView.snp.trailing).offset(-20.0)
            $0.bottom.equalTo(alertBgView.snp.bottom).offset(-20.0)
            $0.width.equalTo(cancelBtn.snp.width)
            $0.height.equalTo(48.0)
        }
        
    }
}
