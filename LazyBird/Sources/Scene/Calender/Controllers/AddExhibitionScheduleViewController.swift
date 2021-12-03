//
//  AddExhibitionScheduleViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/03.
//

import UIKit

class AddExhibitionScheduleViewController: UIViewController {
    //MARK: - UI Components
    let alertLabel = UILabel().then{
        $0.text = "일정 등록을 위해\n전시회 정보를 입력해주세요."
        $0.font = UIFont.TTFont(type: .SDBold, size: 20)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    let exhibitionNameLabel = UILabel().then{
        $0.text = "전시"
        $0.font = UIFont.TTFont(type: .SDMed, size: 15)
        $0.textColor = .white
    }
    
    let exhibitionInputTextField = CalendarCustomTextField().then{
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.attributedPlaceholder = NSAttributedString(string: "전시회 이름",
                                                      attributes: [NSAttributedString.Key.foregroundColor : UIColor.Basic.gray03])
        $0.textColor = .white
        $0.layer.cornerRadius = 5
    }
    
    let stationNameLabel = UILabel().then{
        $0.text = "장소"
        $0.font = UIFont.TTFont(type: .SDMed, size: 15)
        $0.textColor = .white
    }
    
    let stationInputTextField = CalendarCustomTextField().then{
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.attributedPlaceholder = NSAttributedString(string: "전시회 장소",
                                                       attributes: [NSAttributedString.Key.foregroundColor : UIColor.Basic.gray03])
        $0.textColor = .white
        $0.layer.cornerRadius = 5
    }
    
    let previewScheduleAlertLabel = UILabel().then{
        $0.text = "관람 일정"
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .SDMed, size: 15)
    }
    
    let dateLabel = UILabel().then{
        $0.text = "날짜"
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .SDMed, size: 11)
    }
    
    lazy var dateSettingBtn = UIButton().then{
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(dateSettingBtnPressed(_:)), for: .touchUpInside)
    }
    
    let timeLabel = UILabel().then{
        $0.text = "시간"
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .SDMed, size: 11)
    }
    
    lazy var startTimeBtn = UIButton().then{
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(startTimeBtnPressed(_:)), for: .touchUpInside)
    }
    
    let waveLabel = UILabel().then{
        $0.text = "~"
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .MontReg, size: 24)
    }
    
    lazy var endTimeBtn = UIButton().then{
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(endTimeBtnPressed(_:)), for: .touchUpInside)
    }

    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.darkGray02
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(moveToAddSchedule(_:))))
        setUI()
        setNavigationItem()
    }
    
    //MARK: - Functions
    @objc func moveToAddSchedule(_ sender: Any){
        self.view.endEditing(true)
    }
    
    @objc func dateSettingBtnPressed(_ sender: Any){
        //TODO: 캘린더 또 띄워야함 ㅅㅂ..
    }
    
    @objc func startTimeBtnPressed(_ sender: UIButton){
        //TODO: 시작날짜
    }
    
    @objc func endTimeBtnPressed(_ sender: UIButton){
        //TODO: 끝 날짜
    }
    
    func setNavigationItem(){
        self.navigationItem.title = "전시 일정 추가"
        // Title 설정
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.Background.darkGray02
        self.navigationController?.navigationBar.shadowImage = colorToImage()
        self.navigationController?.navigationBar.isTranslucent = false
        // navigationbar backbutton 설정
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_arrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_arrow")
    }
    
    func setUI(){
        self.view.addSubview(alertLabel)
        self.view.addSubview(exhibitionNameLabel)
        self.view.addSubview(exhibitionInputTextField)
        self.view.addSubview(stationNameLabel)
        self.view.addSubview(stationInputTextField)
        self.view.addSubview(previewScheduleAlertLabel)
        self.view.addSubview(dateLabel)
        self.view.addSubview(dateSettingBtn)
        self.view.addSubview(timeLabel)
        self.view.addSubview(startTimeBtn)
        self.view.addSubview(waveLabel)
        self.view.addSubview(endTimeBtn)
        
        alertLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(24.0)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(24.0)
        }
        
        exhibitionNameLabel.snp.makeConstraints{
            $0.top.equalTo(alertLabel.snp.bottom).offset(38.0)
            $0.leading.equalTo(alertLabel.snp.leading)
        }
        
        exhibitionInputTextField.snp.makeConstraints{
            $0.top.equalTo(exhibitionNameLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(exhibitionNameLabel.snp.leading)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-24.0)
            $0.height.equalTo(48.0)
        }
        
        stationNameLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitionInputTextField.snp.bottom).offset(16.0)
            $0.leading.equalTo(alertLabel.snp.leading)
        }
        
        stationInputTextField.snp.makeConstraints{
            $0.top.equalTo(stationNameLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(exhibitionNameLabel.snp.leading)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-24.0)
            $0.height.equalTo(48.0)
        }
        
        previewScheduleAlertLabel.snp.makeConstraints{
            $0.top.equalTo(stationInputTextField.snp.bottom).offset(32.0)
            $0.leading.equalTo(alertLabel.snp.leading)
        }
        
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(previewScheduleAlertLabel.snp.bottom).offset(16.0)
            $0.leading.equalTo(alertLabel.snp.leading)
        }
        
        dateSettingBtn.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(alertLabel.snp.leading)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-24.0)
            $0.height.equalTo(48.0)
        }
        
        timeLabel.snp.makeConstraints{
            $0.top.equalTo(dateSettingBtn.snp.bottom).offset(16.0)
            $0.leading.equalTo(alertLabel.snp.leading)
        }
        
        startTimeBtn.snp.makeConstraints{
            $0.top.equalTo(timeLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(alertLabel.snp.leading)
            $0.width.equalTo(dateSettingBtn.snp.width).multipliedBy(0.45259938837)
            $0.height.equalTo(48.0)
        }
        
        waveLabel.snp.makeConstraints{
            $0.centerX.equalTo(dateSettingBtn.snp.centerX)
            $0.centerY.equalTo(startTimeBtn.snp.centerY)
            $0.width.equalTo(14.0)
            $0.height.equalTo(29.0)
        }
        
        endTimeBtn.snp.makeConstraints{
            $0.top.equalTo(timeLabel.snp.bottom).offset(8.0)
            $0.trailing.equalTo(dateSettingBtn.snp.trailing)
            $0.width.equalTo(dateSettingBtn.snp.width).multipliedBy(0.45259938837)
            $0.height.equalTo(48.0)
        }
    }
    
    private func colorToImage() -> UIImage {
        let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        let image: UIImage = UIGraphicsImageRenderer(size: size).image { context in
            UIColor.Background.darkGray01.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        return image
    }
}
