//
//  ExhibitionDateSelectViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/04.
//

import UIKit
import SnapKit
import Then
import FSCalendar

class ExhibitionDateSelectViewController: UIViewController {
    //MARK: - Properties
    let viewModel = ExhibitionDateSelectViewModel()
    var delegate: AddExhibitionScheduleViewDelegate?
    
    let dateFormatter: DateFormatter = DateFormatter().then{
        $0.locale = Locale(identifier: "ko_KR")
        $0.dateFormat = "yyyy"
    }
    
    let dateFormatterForAPI: DateFormatter = DateFormatter().then{
        $0.locale = Locale(identifier: "ko_KR")
        $0.dateFormat = "yyyy-MM-dd"
    }
    
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
    
    let alertLabel = UILabel().then{
        $0.text = "날짜 선택하기"
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
    }
    
    lazy var dismissBtn = UIButton().then{
        $0.setImage(UIImage(named: "ic_close"), for: .normal)
        $0.addTarget(self, action: #selector(dismissBtnPressed(_:)), for: .touchUpInside)
    }
    
    let yearLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .MontReg, size: 20)
        $0.textColor = .white
    }
    
    lazy var nextBtn = UIButton().then{
        $0.setImage(UIImage(named: "ic_next"), for: .normal)
        $0.addTarget(self, action: #selector(nextBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var postBtn = UIButton().then{
        $0.setImage(UIImage(named: "ic_post"), for: .normal)
        $0.addTarget(self, action: #selector(postBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var calender: FSCalendar = FSCalendar().then{
        $0.dataSource = self
        $0.delegate = self
        $0.allowsMultipleSelection = false
        $0.headerHeight = 50
        $0.appearance.borderRadius = 1
        $0.appearance.headerMinimumDissolvedAlpha = 0.0
        $0.appearance.headerDateFormat = "M월"
        $0.appearance.headerTitleColor = .white
        $0.appearance.headerTitleFont = UIFont.TTFont(type: .MontBold, size: 20)
        $0.scrollDirection = .horizontal
        $0.appearance.titleDefaultColor = .white // 일반 날짜 색
        $0.appearance.titleFont = UIFont.TTFont(type: .MontReg, size: 15) // 일반 날짜 폰트
        $0.appearance.weekdayTextColor = .white // 위에 월 화 수목금토일 색
        $0.appearance.weekdayFont = UIFont.TTFont(type: .MontSemiBold, size: 17) // 위에 월 화 수목금토일 폰트
        $0.appearance.headerTitleColor = .white // 헤더 색
        $0.appearance.selectionColor = UIColor.Point.or01 // 선택된 셀 컬러
        $0.appearance.todayColor = UIColor.Basic.gray02 // 오늘 컬러
        $0.appearance.todaySelectionColor = UIColor.Point.or01
        $0.appearance.headerMinimumDissolvedAlpha = 0
        $0.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesSingleUpperCase // 월화수목금토일 -> S M T ....
        $0.backgroundColor = UIColor.Background.black02
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.layer.cornerRadius = 20
    }
    
    lazy var bookBtn = UIButton().then{
        $0.backgroundColor = UIColor.Basic.gray01
        $0.setTitle("예매하기", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(bookBtnPressed(_:)), for: .touchUpInside)
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
    
    @objc func bookBtnPressed(_  sender: UIButton){
        //TODO: 날짜 정보 보내고, 화면 dismiss
        self.delegate?.getSelectedDate(date: self.viewModel.selectedDate)
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func postBtnPressed(_ sender: UIButton){
        self.scrollCurrentPage(isPrev: true)
    }
    
    @objc func nextBtnPressed(_ sender: UIButton){
        self.scrollCurrentPage(isPrev: false)
    }
    
    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        self.viewModel.currentPage.value = cal.date(byAdding: dateComponents, to: self.viewModel.currentPage.value) ?? Date()
        self.calender.setCurrentPage(self.viewModel.currentPage.value, animated: true)

    }
    
    func setBind(){
        self.viewModel.currentPage.bind { date in
            print("current page bind called")
            self.yearLabel.text = "\(self.dateFormatter.string(from: self.calender.currentPage))"
        }
        print("self calendar current page --> \(self.calender.currentPage)")
        self.viewModel.setCurrentPage(currentPage: self.calender.currentPage) // 현재 페이지 세팅
    }
    
    func setUI(){
        self.view.addSubview(opaBgView)
        self.view.addSubview(bgView)
        bgView.addSubview(alertLabel)
        bgView.addSubview(dismissBtn)
        bgView.addSubview(calender)
        bgView.addSubview(yearLabel)
        bgView.addSubview(nextBtn)
        bgView.addSubview(postBtn)
        bgView.addSubview(bookBtn)
        
        opaBgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        bgView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(478.0)
        }
        
        alertLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        dismissBtn.snp.makeConstraints{
            $0.centerY.equalTo(alertLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-16.0)
        }
        
        calender.snp.makeConstraints{
            $0.top.equalTo(alertLabel.snp.bottom).offset(40.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(298.0)
        }
        
        yearLabel.snp.makeConstraints{
            $0.centerY.equalTo(calender.calendarHeaderView.snp.centerY)
            $0.leading.equalToSuperview().offset(22.0)
        }
        
        nextBtn.snp.makeConstraints{
            $0.centerY.equalTo(calender.calendarHeaderView.snp.centerY)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-16.0)
        }
        
        postBtn.snp.makeConstraints{
            $0.centerY.equalTo(calender.calendarHeaderView.snp.centerY)
            $0.trailing.equalTo(nextBtn.snp.leading).offset(-8.0)
        }
        
        bookBtn.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-38.0)
            $0.height.equalTo(48.0)
        }
    }
}

extension ExhibitionDateSelectViewController: FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance{
    //이벤트가 존재한다면, 이벤트 표시. return은  이벤트의 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        if self.events.contains(date) {
//            return 3
//        } else {
//            return 0
//        }
        return 0
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.viewModel.setCurrentPage(currentPage: calendar.currentPage)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.viewModel.setSelectedDate(dateFormatterForAPI.string(from: date))
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.view.layoutIfNeeded()
    }
}
