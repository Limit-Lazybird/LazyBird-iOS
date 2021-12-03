//
//  CalenderViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/01.
//

import UIKit
import SnapKit
import Then
import FSCalendar

class CalendarViewController: UIViewController {
    //MARK: - Properties
    let viewModel = CalendarViewModel()
    var events = [Date]() // 일단 이벤트가 있는 더미 날짜
    
    lazy var dateFormatter: DateFormatter = DateFormatter().then{
        $0.locale = Locale(identifier: "ko_KR")
        $0.dateFormat = "yyyy"
    }
    
    let dateFormatterForAPI: DateFormatter = DateFormatter().then{
        $0.locale = Locale(identifier: "ko_KR")
        $0.dateFormat = "yyyymm"
    }
    
    //MARK: - UI Components
    
    lazy var scheduleBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(scheduleBtnPressed(_:))).then{
        $0.image = UIImage(named: "ic_schedule_add")
        $0.tintColor = .white
    }
    
    lazy var tableView = UITableView().then{
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.identifier)
    }
    
    let separatorView = UIView().then{
        $0.backgroundColor = UIColor.Background.darkGray01
    }
    
    let unregisteredExhibitionAlertView = UnregisteredExhibitionAlertView()
    
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
        $0.backgroundColor = UIColor.Background.darkGray02
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.layer.cornerRadius = 20
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02

        setUI()
        setBind()
        setConfig()
        setNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        /* 예약이 된 전시지만 캘린더에 등록이 안된 리스트를 출력하는 API */
        self.viewModel.requestUnregistedSchedules()
    }
    
    //MARK: - Functions
    @objc func postBtnPressed(_ sender: UIButton){
        self.scrollCurrentPage(isPrev: true)
    }
    
    @objc func nextBtnPressed(_ sender: UIButton){
        self.scrollCurrentPage(isPrev: false)
    }
    
    @objc func scheduleBtnPressed(_ sender: UIButton){
        //TODO: 전시 추가 일정으로 이동
        let addExhibitionScheduleVC = AddExhibitionScheduleViewController()
        addExhibitionScheduleVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addExhibitionScheduleVC, animated: true)
    }
    
    func setNavigationItem(){
        self.navigationItem.title = "캘린더"
        self.navigationItem.rightBarButtonItems = [scheduleBtn]
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
    
    func setBind(){
        // 현재 페이지 정보 바인딩
        self.viewModel.currentPage.bind { date in
            print("current page bind called")
            self.yearLabel.text = "\(self.dateFormatter.string(from: self.calender.currentPage))"
        }
        print("self calendar current page --> \(self.calender.currentPage)")
        self.viewModel.setCurrentPage(currentPage: self.calender.currentPage) // 현재 페이지 세팅
        
        // 월별 스케쥴 리스트 정보 바인딩
        self.viewModel.monthlySchedules.bind { schedules in
            print("monthlySchedules bind called")
            self.tableView.reloadData()
        }
        self.viewModel.requestSchedules(reser_dt: dateFormatterForAPI.string(from: self.calender.currentPage)) // 현재 달의 스케줄 리스트 세팅
        
        // 예약이 된 전시지만 캘린더에 등록이 안된 전시 수 정보 바인딩
        self.viewModel.unregistedSchedules.bind { schedules in
            print("unregistedSchedules bind called")
            self.unregisteredExhibitionAlertView.config(alertCnt: "\(schedules.count)")
        }
    }
    
    func setConfig(){
        self.unregisteredExhibitionAlertView.config(alertCnt: "2")
    }
    
    func setUI(){
        self.view.addSubview(unregisteredExhibitionAlertView)
        self.view.addSubview(calender)
        self.view.addSubview(separatorView)
        self.view.addSubview(yearLabel)
        self.view.addSubview(nextBtn)
        self.view.addSubview(postBtn)
        self.view.addSubview(tableView)
        
        
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
        
        unregisteredExhibitionAlertView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55.0)
        }
        
        calender.snp.makeConstraints{
            $0.top.equalTo(unregisteredExhibitionAlertView.snp.bottom)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(330.0)
        }
        
        separatorView.snp.makeConstraints{
            $0.top.equalTo(calender.snp.top)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.height.equalTo(2.0)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(calender.snp.bottom)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        self.viewModel.currentPage.value = cal.date(byAdding: dateComponents, to: self.viewModel.currentPage.value) ?? Date()
        self.calender.setCurrentPage(self.viewModel.currentPage.value, animated: true)

    }
    
    private func colorToImage() -> UIImage {
        let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        let image: UIImage = UIGraphicsImageRenderer(size: size).image { context in
            UIColor.Background.darkGray02.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        return image
    }
}

//MARK: Calendar Extension

extension CalendarViewController: FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance{
    //이벤트가 존재한다면, 이벤트 표시. return은  이벤트의 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.events.contains(date) {
            return 3
        } else {
            return 0
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.viewModel.setCurrentPage(currentPage: calendar.currentPage)
        self.viewModel.requestSchedules(reser_dt: dateFormatterForAPI.string(from: calendar.currentPage))
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.view.layoutIfNeeded()
    }
}

//MARK: - TableView Extension

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell else {
            return UITableViewCell()
        }
        cell.config(title: "Wed", num: "10")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
