//
//  SelectUnregisteredExhibitionViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/06.
//

import UIKit
import SnapKit
import Then

//TODO: 여기서 캘린더에 등록되지 않은 전시 리스트 목록들을 불러오자. 이전 뷰에서 정보 받아오는게 맞을거같다.

protocol SelectUnregisteredExhibitionViewDelegate{
    func setSelectedExhibition(title: String) // pikcerView에서 설정한 값 뷰모델에 저장
}

class SelectUnregisteredExhibitionViewController: UIViewController {
    //MARK: - Properties
    let dummyTitles: [String] = ["무슨전시","무슨 전시", "무슨 전시"]
    
    //MARK: - UI Components
    lazy var opaBgView = UIView().then{
        $0.backgroundColor = UIColor.Opacity.black80
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(dismissBtnPressed(_:))))
    }
    
    let bgView = UIView().then{
        $0.backgroundColor = UIColor.Background.black02
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 20
    }
    
    let alertLable = UILabel().then{
        $0.text = "전시 선택하기"
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
    }
    
    lazy var dismissBtn = UIButton().then{
        $0.setImage(UIImage(named: "ic_close"), for: .normal)
        $0.addTarget(self, action: #selector(dismissBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var exhibitionPickerView = CustomPickerView().then{
        $0.selectExbihitionDelegate = self
    }
    
    lazy var completeBtn = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.Basic.gray01
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(completeBtnPressed(_:)), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        setUI()
        setBind()
    }
    
    //MARK: - Functions
    @objc func dismissBtnPressed(_ sender: UIButton){
        //TODO: 화면 dismiss
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func completeBtnPressed(_ sender: UIButton){
        //TODO: 설정한 시간 값 넘기고, 화면 dismiss
//        self.delegate?.getSelectedTime(time: self.viewModel.getSelectedTime(), type: self.timeSelectType!)
        self.dismiss(animated: false, completion: nil)
    }
    
    func setBind(){
        exhibitionPickerView.selectExhibitionViewConfig(titles: self.dummyTitles)
    }
    
    func setUI(){
        self.view.addSubview(opaBgView)
        self.view.addSubview(bgView)
        bgView.addSubview(alertLable)
        bgView.addSubview(dismissBtn)
        bgView.addSubview(exhibitionPickerView)
        bgView.addSubview(completeBtn)
        
        opaBgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        bgView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(290.0)
        }
        
        alertLable.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        dismissBtn.snp.makeConstraints{
            $0.centerY.equalTo(alertLable.snp.centerY)
            $0.trailing.equalToSuperview().offset(-16.0)
        }
        
        exhibitionPickerView.snp.makeConstraints{
            $0.top.equalTo(alertLable.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(36.0)
            $0.width.equalTo((self.view.frame.width - 72.0))
            $0.height.equalTo(120.0)
        }
        
        completeBtn.snp.makeConstraints{
            $0.top.equalTo(exhibitionPickerView.snp.bottom).offset(24.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-38.0)
            $0.height.equalTo(48.0)
        }
    }
}

extension SelectUnregisteredExhibitionViewController: SelectUnregisteredExhibitionViewDelegate{
    func setSelectedExhibition(title: String){
        //TODO: pickerView에서 설정한 값 뷰모델에 저장하기
        print("pickerView selected title -> \(title)")
    }
}
