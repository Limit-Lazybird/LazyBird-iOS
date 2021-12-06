//
//  AddExhibitionScheduleViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/03.
//

import UIKit

protocol AddExhibitionScheduleViewDelegate{
    func getSelectedDate(date: String) // 캘린더에서 받아온 날짜 받아와서 넣어주기
    func getSelectedTime(time: String, type: TimeSelectType) // 시간 받아와서 세팅
}

class AddExhibitionScheduleViewController: UIViewController {
    //MARK: - Properties
    let viewModel = AddExhibitionScheduleViewModel()
    
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
        $0.setTitle("선택", for: .normal)
        $0.setImage(UIImage(named: "ic_expand_down_light")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = UIColor.Basic.gray03
        $0.setTitleColor(UIColor.Basic.gray03, for: .normal)
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.semanticContentAttribute = .forceRightToLeft
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: -122, bottom: 0, right: 122.0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 130, bottom: 0, right: -130)
        $0.addTarget(self, action: #selector(dateSettingBtnPressed(_:)), for: .touchUpInside)
        $0.layer.cornerRadius = 5
    }
    
    let timeLabel = UILabel().then{
        $0.text = "시간"
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .SDMed, size: 11)
    }
    
    lazy var startTimeBtn = UIButton().then{
        $0.semanticContentAttribute = .forceRightToLeft
        $0.setTitle("선택", for: .normal)
        $0.setImage(UIImage(named: "ic_expand_down_light")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = UIColor.Basic.gray03
        $0.setTitleColor(UIColor.Basic.gray03, for: .normal)
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: -36, bottom: 0, right: 36.0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 42, bottom: 0, right: -42)
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(startTimeBtnPressed(_:)), for: .touchUpInside)
    }
    
    let waveLabel = UILabel().then{
        $0.text = "~"
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .MontReg, size: 24)
    }
    
    lazy var endTimeBtn = UIButton().then{
        $0.semanticContentAttribute = .forceRightToLeft
        $0.setTitle("선택", for: .normal)
        $0.setImage(UIImage(named: "ic_expand_down_light")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = UIColor.Basic.gray03
        $0.setTitleColor(UIColor.Basic.gray03, for: .normal)
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: -36, bottom: 0, right: 36.0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 42, bottom: 0, right: -42)
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(endTimeBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var deleteBtn = UIButton().then{
        $0.backgroundColor = UIColor.Basic.gray01
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.layer.cornerRadius = 10
    }
    
    lazy var registBtn = UIButton().then{
        $0.backgroundColor = UIColor.Point.or01
        $0.setTitle("등록", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(registBtnPressed(_:)), for: .touchUpInside)
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
    
    @objc func registBtnPressed(_ sender: UIButton){
        //TODO: 서버로 일정 등록 api 전송하기
        //TODO: 필요한 정보 - 1. 이름 / 2. 장소 / 3. 날짜 / 4. 시작시간 / 5. 끝시간
        if checkRequestParameter(){ // parameter 유효한지 check
            //TODO: request
            let customInfo = CustomInfoSaveRequest(exhbt_nm: exhibitionInputTextField.text ?? "",
                                  exhbt_lct: stationInputTextField.text ?? "",
                                  reser_dt: dateSettingBtn.titleLabel?.text ?? "",
                                  start_time: startTimeBtn.titleLabel?.text ?? "",
                                  end_time: endTimeBtn.titleLabel?.text ?? "")
            
            self.viewModel.requestSaveCustomSchedule(customSchedule: customInfo)
            self.navigationController?.popViewController(animated: true)
        }else{
            //TODO: 경고창 띄우거나 request 안함
            print("경고 !! parameter가 유효하지 안타!!")
        }
    }
    
    @objc func dateSettingBtnPressed(_ sender: Any){
        //TODO: 캘린더 또 띄워야함 ㅅㅂ..
        let exhibitionDateSelectVC = ExhibitionDateSelectViewController()
        exhibitionDateSelectVC.delegate = self
        exhibitionDateSelectVC.modalPresentationStyle = .overFullScreen
        
        self.present(exhibitionDateSelectVC, animated: true, completion: nil)
    }
    
    @objc func startTimeBtnPressed(_ sender: UIButton){
        //TODO: 시작날짜
        let exhibitionTimeSelectVC = ExhibitionTimeSelectViewController()
        exhibitionTimeSelectVC.delegate = self
        exhibitionTimeSelectVC.timeSelectType = .startTime
        exhibitionTimeSelectVC.modalPresentationStyle = .overFullScreen
        
        self.present(exhibitionTimeSelectVC, animated: true, completion: nil)
    }
    
    @objc func endTimeBtnPressed(_ sender: UIButton){
        //TODO: 끝 날짜
        let exhibitionTimeSelectVC = ExhibitionTimeSelectViewController()
        exhibitionTimeSelectVC.delegate = self
        exhibitionTimeSelectVC.timeSelectType = .endTime
        exhibitionTimeSelectVC.modalPresentationStyle = .overFullScreen
        
        self.present(exhibitionTimeSelectVC, animated: true, completion: nil)
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
        self.view.addSubview(deleteBtn)
        self.view.addSubview(registBtn)
        
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
        
        registBtn.snp.makeConstraints{
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-24.0)
            $0.bottom.equalToSuperview().offset(-38.0)
            $0.width.equalTo(self.view.frame.width * 0.536)
            $0.height.equalTo(48.0)
        }
        
        deleteBtn.snp.makeConstraints{
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(24.0)
            $0.trailing.equalTo(registBtn.snp.leading).offset(-8.0)
            $0.bottom.equalToSuperview().offset(-38.0)
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
    
    private func checkRequestParameter() -> Bool{
        if let exhibitTitle =  self.exhibitionInputTextField.text{
            if exhibitTitle == "" {
                return false
            }
        }
        
        if let stationTitle = self.stationInputTextField.text{
            if stationTitle == ""{
                return false
            }
        
        }
        if let checkedTitle = self.dateSettingBtn.titleLabel {
            if checkedTitle.text == "선택"{ // setting 전 이라면
                return false
            }
        }
        if let checkedStartTime = self.startTimeBtn.titleLabel {
            if checkedStartTime.text == "선택"{
                return false
            }
        }
        
        if let checkedEndTime = self.endTimeBtn.titleLabel {
            if checkedEndTime.text == "선택" {
                return false
            }
        }
        
        return true
    }
}

extension AddExhibitionScheduleViewController: AddExhibitionScheduleViewDelegate{
    /* 캘린더에서 받아온 날짜 받아와서 넣어주기 */
    func getSelectedDate(date: String){
        //TODO: 받아온 값으로 버튼의 텍스트, 색 변경하기
        self.dateSettingBtn.setTitle(date, for: .normal)
        self.dateSettingBtn.setTitleColor(.white, for: .normal)
        self.dateSettingBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -92, bottom: 0, right: 92.0)
        self.dateSettingBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: -100)
    }
    /* 시간 받아와서 세팅 */
    func getSelectedTime(time: String, type: TimeSelectType){
        print("time -> \(time), type -> \(type)")
        //TODO: 시작 시간 설정이면 startBtn 텍스트, 색 변경 / 끝 시간 설정이어도 endBtn에 동일 적용
        switch type {
        case .startTime:
            self.startTimeBtn.setTitle(time, for: .normal)
            self.startTimeBtn.setTitleColor(.white, for: .normal)
            self.startTimeBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -24, bottom: 0, right: 24)
            self.startTimeBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: -32)
        case .endTime:
            self.endTimeBtn.setTitle(time, for: .normal)
            self.endTimeBtn.setTitleColor(.white, for: .normal)
            self.endTimeBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -24, bottom: 0, right: 24)
            self.endTimeBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: -32)
        }
    }
}
