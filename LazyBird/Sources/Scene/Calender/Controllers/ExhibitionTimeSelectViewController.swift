//
//  ExhibitionTimeSelectViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/05.
//

import UIKit
import SnapKit
import Then

enum TimeSelectType{
    case startTime
    case endTime
}

enum PickerType{
    case ampm
    case hour
    case min
}

protocol ExhibitionTimeSelectViewDelegate{
    func setSelectedTitle(title: String, type: PickerType) // pikcerView에서 설정한 값 뷰모델에 저장
}

class ExhibitionTimeSelectViewController: UIViewController {
    //MARK: - Properties
    let viewModel = ExhibitionTimeSelectViewModel()
    var delegate: AddExhibitionScheduleViewDelegate?
    var timeSelectType: TimeSelectType?
    
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
        $0.text = "시간 선택하기"
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
    }
    
    lazy var dismissBtn = UIButton().then{
        $0.setImage(UIImage(named: "ic_close"), for: .normal)
        $0.addTarget(self, action: #selector(dismissBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var ampmPickerView = CustomPickerView().then{
        $0.delegate = self
    }
    lazy var hourPickerView = CustomPickerView().then{
        $0.delegate = self
    }
    lazy var minPickerView = CustomPickerView().then{
        $0.delegate = self
    }
    
    let colonLabel = UILabel().then{
        $0.text = ":"
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .MontSemiBold, size: 20)
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
        self.delegate?.getSelectedTime(time: self.viewModel.getSelectedTime(), type: self.timeSelectType!)
        self.dismiss(animated: false, completion: nil)
    }
    
    func setBind(){
        self.ampmPickerView.config(titles: self.viewModel.ampm, type: .ampm)
        self.hourPickerView.config(titles: self.viewModel.hour, type: .hour)
        self.minPickerView.config(titles: self.viewModel.min, type: .min)
    }
    
    func setUI(){
        self.view.addSubview(opaBgView)
        self.view.addSubview(bgView)
        bgView.addSubview(alertLable)
        bgView.addSubview(dismissBtn)
        bgView.addSubview(ampmPickerView)
        bgView.addSubview(hourPickerView)
        bgView.addSubview(minPickerView)
        bgView.addSubview(colonLabel)
        bgView.addSubview(completeBtn)
        
        opaBgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        bgView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(320.0)
        }
        
        alertLable.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        dismissBtn.snp.makeConstraints{
            $0.centerY.equalTo(alertLable.snp.centerY)
            $0.trailing.equalToSuperview().offset(-16.0)
        }
        
        ampmPickerView.snp.makeConstraints{
            $0.top.equalTo(alertLable.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(50.0)
            $0.width.equalTo((self.view.frame.width - 152) / 3)
            $0.height.equalTo(120.0)
        }
        
        hourPickerView.snp.makeConstraints{
            $0.top.equalTo(ampmPickerView.snp.top)
            $0.leading.equalTo(ampmPickerView.snp.trailing).offset(26.0)
            $0.width.equalTo(ampmPickerView.snp.width)
            $0.height.equalTo(120.0)
        }
        
        minPickerView.snp.makeConstraints{
            $0.top.equalTo(ampmPickerView.snp.top)
            $0.leading.equalTo(hourPickerView.snp.trailing).offset(26.0)
            $0.width.equalTo(ampmPickerView.snp.width)
            $0.height.equalTo(120.0)
        }
        
        colonLabel.snp.makeConstraints{
            $0.centerY.equalTo(ampmPickerView.snp.centerY)
            $0.leading.equalTo(hourPickerView.snp.trailing).offset(12.0)
        }
        
        completeBtn.snp.makeConstraints{
            $0.top.equalTo(ampmPickerView.snp.bottom).offset(24.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-38.0)
            $0.height.equalTo(48.0)
        }
    }
}

extension ExhibitionTimeSelectViewController: ExhibitionTimeSelectViewDelegate{
    func setSelectedTitle(title: String, type: PickerType) {
        print("호출 되니?")
        switch type{
        case .ampm:
            self.viewModel.setSelectedAmpmTitle(ampm: title)
        case .hour:
            self.viewModel.setSelectedHourTitle(hour: title)
        case .min:
            self.viewModel.setSelectedMinTitle(min: title)
        }
    }
}
