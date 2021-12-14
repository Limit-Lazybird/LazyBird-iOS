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

protocol CalendarViewDelegate{
    func moveToSelectUnregisteredExhibition() // 캘린더에 저장되지 않은 예약 전시 리스트 선택 화면으로 이동
    func moveToAddExhibitionSchedule(selectedSchedule: Schedule)
    func moveToAddExhibitionScheduleForEdit(schedule: Schedule) // 캘린더 등록된 일정 수정
    func moveToExhibitionVisitAlert(currentSchedule: Schedule, indexPath: Int) // alert view 띄우기
    func moveToEditOrDeleteAlert(currentSchedule: Schedule) // 수정, 삭제 알림 화면으로 이동
    func cancelBtnPressed(currentSchedule: Schedule, indexPath: Int) // 전시 방문 취소
    func completeBtnPressed(currentSchedule: Schedule, indexPath: Int) // 전시 방문
    func deleteCustomSchedule(schedule: Schedule) // 커스텀 전시 일정 삭제
    func deleteBookedSchedule(schedule: Schedule) // 예매된 전시 일정 삭제
}

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
        $0.dateFormat = "yyyyMM"
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
    
    lazy var unregisteredExhibitionAlertView = UnregisteredExhibitionAlertView().then{
        $0.delegate = self
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
        $0.appearance.eventDefaultColor = UIColor.Point.or01 // 이벤트 default color
        $0.appearance.eventSelectionColor = UIColor.Point.green01 // 이벤트 selection Color
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
        print("e다시 그려지는거십니가?")
        
        /* 예약이 된 전시지만 캘린더에 등록이 안된 리스트를 출력하는 API */
        self.viewModel.requestUnregistedSchedules(){
            
        }
        /* 캘린더에 저장된 전시 예약 정보 (월별) + 개인 전시 일정 리스트 (월별) Request */
        self.viewModel.requestMonthlySchedules(reser_dt: dateFormatterForAPI.string(from: self.calender.currentPage))
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
        addExhibitionScheduleVC.additionalType = .custom
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
            print("-=-=-=-=-=-=-=- \(schedules) -=-=-=-=-=-=-==")
            self.tableView.reloadData()
            self.calender.reloadData()
        }
//        self.viewModel.requestMonthlySchedules(reser_dt: dateFormatterForAPI.string(from: self.calender.currentPage)) // 현재 달의 스케줄 리스트 세팅
        
        // 예약이 된 전시지만 캘린더에 등록이 안된 전시 수 정보 바인딩
        self.viewModel.unregistedSchedules.bind { schedules in
            print("unregistedSchedules bind called")
            self.unregisteredExhibitionAlertView.config(alertCnt: "\(schedules.count)")
            /* 캘린더에 등록되지 않은 전시회 개수 0개일때 layout 변경 */
            self.updateLayoutUnregisteredExhibitionAlertView()
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

    private func updateLayoutUnregisteredExhibitionAlertView(){
        if self.viewModel.unregistedSchedules.value.count == 0{
            print("count = 0")
            unregisteredExhibitionAlertView.snp.remakeConstraints{
                $0.top.equalTo(self.view.safeAreaLayoutGuide)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(0.0)
            }
        }else{
            print("count > 0")
            unregisteredExhibitionAlertView.snp.remakeConstraints{
                $0.top.equalTo(self.view.safeAreaLayoutGuide)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(55.0)
            }
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
    
    /* monthlySchedules의 앞 schedule과 비교해서  */
    private func checkDuplicateDate(indexPath: IndexPath) -> Bool{
        if indexPath.row > 0{
            //TODO: 두번째 녀석부터 내 앞녀석이랑 날짜 문자열이 같다면 빈 문자열 보내기 ->true return
            if self.viewModel.monthlySchedules.value[indexPath.row].reser_dt == self.viewModel.monthlySchedules.value[indexPath.row - 1].reser_dt {
                return true
            }
        }
        return false
    }
    
    private func getCompleteRequestParameter(currentSchedule: Schedule) -> ExhibitionVisitRequest{
        if currentSchedule.isCustom!{
            let paremeter = ExhibitionVisitRequest(exhbt_cd: currentSchedule.exhbt_cd,
                                                   visit_yn: "Y",
                                                   exhbt_type: "custom")
            return paremeter
        }else{
            let paremeter = ExhibitionVisitRequest(exhbt_cd: currentSchedule.exhbt_cd,
                                                   visit_yn: "Y",
                                                   exhbt_type: nil)
            return paremeter
        }
    }
    
    private func getCancelRequestParameter(currentSchedule: Schedule) -> ExhibitionVisitRequest{
        if currentSchedule.isCustom!{
            let paremeter = ExhibitionVisitRequest(exhbt_cd: currentSchedule.exhbt_cd,
                                                   visit_yn: "N",
                                                   exhbt_type: "custom")
            return paremeter
        }else{
            let paremeter = ExhibitionVisitRequest(exhbt_cd: currentSchedule.exhbt_cd,
                                                   visit_yn: "N",
                                                   exhbt_type: nil)
            return paremeter
        }
    }
}

//MARK: Calendar Extension

extension CalendarViewController: FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance{
    //이벤트가 존재한다면, 이벤트 표시. return은  이벤트의 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.viewModel.events.value.contains(date){
            //TODO: 해당하는 날짜에 몇개의 이벤트가 있는지 판별
            return self.viewModel.events.value.filter{ $0 == date }.count
        }else{
            return 0
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.viewModel.setCurrentPage(currentPage: calendar.currentPage) // 현재 페이지에서 넘겼을때, 페이지 set
        self.viewModel.requestMonthlySchedules(reser_dt: dateFormatterForAPI.string(from: self.calender.currentPage)) // 현재 달의 리스트 정보들을 request
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.view.layoutIfNeeded()
    }
}

//MARK: - TableView Extension

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.monthlySchedules.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell else {
            return UITableViewCell()
        }

        //TODO: 중복 날짜 체크
        if checkDuplicateDate(indexPath: indexPath){
            //TODO: 날짜 빈 문자열로 보내주기
            cell.config(schedule: self.viewModel.monthlySchedules.value[indexPath.row],
                        dayOfWeek: "",
                        dayOfWeekNum: "",
                        indexPath: indexPath.row)
        }else{
            //TODO: 제대로 된 날짜 보내주기 -  1. 요일 / 2. OO 일 구하기
            let day = self.viewModel.monthlySchedules.value[indexPath.row].reser_dt
            
            cell.config(schedule: self.viewModel.monthlySchedules.value[indexPath.row],
                        dayOfWeek: self.viewModel.getDayOfTheWeek(date: day),
                        dayOfWeekNum: self.viewModel.getDayOfTheWeekNum(date: day),
                        indexPath: indexPath.row)
        }
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension CalendarViewController: CalendarViewDelegate{
    /* 캘린더에 저장되지 않은 예약 전시 리스트 선택 화면으로 이동 */
    func moveToSelectUnregisteredExhibition() {
        //TODO: 화면 이동
        let selectUnregisteredExhibitionVC = SelectUnregisteredExhibitionViewController()
        selectUnregisteredExhibitionVC.modalPresentationStyle = .overFullScreen
        selectUnregisteredExhibitionVC.delegate = self
        selectUnregisteredExhibitionVC.viewModel.setUnregistedSchedules(schedule: self.viewModel.unregistedSchedules.value)
        
        self.present(selectUnregisteredExhibitionVC, animated: true, completion: nil)
    }
    
    func moveToAddExhibitionSchedule(selectedSchedule: Schedule){
        print("선택된 스케쥴 정보 =--> \(selectedSchedule)")
        let addExhibitionScheduleVC = AddExhibitionScheduleViewController()
        addExhibitionScheduleVC.hidesBottomBarWhenPushed = true
        addExhibitionScheduleVC.additionalType = .bookedExhibition
        addExhibitionScheduleVC.viewModel.setCurrentExhibition(exhibition: selectedSchedule)
        self.navigationController?.pushViewController(addExhibitionScheduleVC, animated: true)
    }
        
    func moveToExhibitionVisitAlert(currentSchedule: Schedule, indexPath: Int){  // alert view 띄우기
        let exhibitionVisitAlertVC = ExhibitionVisitAlertViewController()
        exhibitionVisitAlertVC.modalPresentationStyle = .overFullScreen
        exhibitionVisitAlertVC.delegate = self
        exhibitionVisitAlertVC.currentSchedule = currentSchedule
        exhibitionVisitAlertVC.currentIndex = indexPath
        
        self.present(exhibitionVisitAlertVC, animated: false, completion: nil)
    }
    
    func cancelBtnPressed(currentSchedule: Schedule, indexPath: Int){
        let parameter = getCancelRequestParameter(currentSchedule: currentSchedule)
        
        self.viewModel.requestExhibitionVisit(exhibitionVisit: parameter) {
            //TODO: 전시회 방문 취소
            print("전시회 방문 취소")
            self.viewModel.monthlySchedules.value[indexPath].setVisitStateToFalse()
        }
    }
    
    func completeBtnPressed(currentSchedule: Schedule, indexPath: Int){
        let parameter = getCompleteRequestParameter(currentSchedule: currentSchedule)
        
        self.viewModel.requestExhibitionVisit(exhibitionVisit: parameter) {
            //TODO: 전시회 방문 처리
            print("전시회 방문 처리")
            self.viewModel.monthlySchedules.value[indexPath].setVisitStateToTrue()
        }
    }
    
    /* 수정, 삭제 알림 화면으로 이동 */
    func moveToEditOrDeleteAlert(currentSchedule: Schedule){
        let exhibitionEditOrDeleteVC = ExhibitionEditOrDeleteViewController()
        exhibitionEditOrDeleteVC.modalPresentationStyle = .overFullScreen
        exhibitionEditOrDeleteVC.delegate = self
        exhibitionEditOrDeleteVC.currentSchedule = currentSchedule
        
        self.present(exhibitionEditOrDeleteVC, animated: false, completion: nil)
    }
    
    /* 캘린더 등록된 일정 수정화면 */
    func moveToAddExhibitionScheduleForEdit(schedule: Schedule){
        let addExhibitionScheduleVC = AddExhibitionScheduleViewController()
        addExhibitionScheduleVC.hidesBottomBarWhenPushed = true
        addExhibitionScheduleVC.isEdit = true
        addExhibitionScheduleVC.viewModel.setCurrentExhibition(exhibition: schedule)
        
        if schedule.isCustom!{
            addExhibitionScheduleVC.additionalType = .custom
        }else{
            addExhibitionScheduleVC.additionalType = .bookedExhibition
        }
        
        self.navigationController?.pushViewController(addExhibitionScheduleVC, animated: true)
    }
    
    /* 커스텀 전시 일정 삭제 */
    func deleteCustomSchedule(schedule: Schedule){
        //TODO: request
        self.viewModel.requestCustomScheduleDelete(exhbt_cd: schedule.exhbt_cd){
            self.viewModel.requestUnregistedSchedules(){ // 예약했지만 등록되지 않은 전시 리스트 불러오기
                self.viewModel.requestMonthlySchedules(reser_dt: self.dateFormatterForAPI.string(from: self.calender.currentPage))
            }
        }
    }
    
    /* 예매된 전시 일정 삭제 */
    func deleteBookedSchedule(schedule: Schedule){
        let parameter = BookedInfoSaveRequest(exhbt_cd: schedule.exhbt_cd,
                                              reser_dt: nil,
                                              start_time: nil,
                                              end_time: nil)
        self.viewModel.requestBookedScheduleDelete(bookedSchedule: parameter){
            self.viewModel.requestUnregistedSchedules(){ // 예약했지만 등록되지 않은 전시 리스트 불러오기
                self.viewModel.requestMonthlySchedules(reser_dt: self.dateFormatterForAPI.string(from: self.calender.currentPage))
            }
            
        }
    }
}
