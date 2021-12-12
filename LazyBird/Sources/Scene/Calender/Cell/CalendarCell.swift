//
//  CalendarCell.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/02.
//

import UIKit
import SnapKit
import Then

class CalendarCell: UITableViewCell {
    //MARK: properties
    static let identifier: String = "calendarCell"
    var delegate: CalendarViewDelegate?
    var currentSchedule: Schedule?
    var currentIndex: Int?
    
    //MARK: - UI Components
    let dayTitleLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .MontReg, size: 16)
        $0.textColor = .white
    }
    
    let dayNumberLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .MontSemiBold, size: 24)
        $0.textColor = .white
    }
    
    let stickView = UIView() // 방문되면 초록색으로
    
    let scheduleContentView = UIView().then{
        $0.backgroundColor = UIColor.Background.darkGray01
        $0.layer.cornerRadius = 10
    }
    
    let exhibitTitleLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.textColor = .white
    }
    let stationLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = .white
    }
    let reservationTimeLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = .white
    }
    lazy var visitBtn = UIButton().then{
        $0.setImage(UIImage(named: "btn_visit_off"), for: .normal)
        $0.setImage(UIImage(named: "btn_visit_on"), for: .selected)
        $0.addTarget(self, action: #selector(visitBtnPressed(_:)), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.Background.black02
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Functions
    @objc func visitBtnPressed(_ sender: UIButton){
        delegate?.moveToExhibitionVisitAlert(currentSchedule: self.currentSchedule!,
                                             indexPath: self.currentIndex ?? 0)
    }
    
    func config(schedule: Schedule, dayOfWeek: String, dayOfWeekNum: String, indexPath: Int){
        self.currentSchedule = schedule // current schedule setting
        self.currentIndex = indexPath
        
        self.dayTitleLabel.text = dayOfWeek
        self.dayNumberLabel.text = dayOfWeekNum
        self.stickView.backgroundColor = .white
        self.exhibitTitleLabel.text = schedule.exhbt_nm
        self.stationLabel.text = schedule.exhbt_lct
        self.reservationTimeLabel.text = "\(schedule.start_time) ~ \(schedule.end_time)"
        
        if schedule.visit_yn == "Y"{
            visitBtn.isSelected = true
            self.stickView.backgroundColor = UIColor.Point.green01
        }else{
            visitBtn.isSelected = false
            self.stickView.backgroundColor = .white
        }
    }
    
    func setUI(){
        self.contentView.addSubview(dayTitleLabel)
        self.contentView.addSubview(dayNumberLabel)
        self.contentView.addSubview(stickView)
        self.contentView.addSubview(scheduleContentView)
        self.scheduleContentView.addSubview(exhibitTitleLabel)
        self.scheduleContentView.addSubview(stationLabel)
        self.scheduleContentView.addSubview(reservationTimeLabel)
        self.scheduleContentView.addSubview(visitBtn)
        
        dayTitleLabel.snp.makeConstraints{
            $0.top.equalTo(scheduleContentView.snp.top)
            $0.leading.equalToSuperview().offset(21.0)
        }
        
        dayNumberLabel.snp.makeConstraints{
            $0.centerX.equalTo(dayTitleLabel.snp.centerX)
            $0.bottom.equalTo(scheduleContentView.snp.bottom)
        }
        
        stickView.snp.makeConstraints{
            $0.top.equalTo(scheduleContentView.snp.top)
            $0.leading.equalToSuperview().offset(69.0)
            $0.bottom.equalTo(scheduleContentView.snp.bottom)
            $0.width.equalTo(2.0)
        }
        
        scheduleContentView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(18.0)
            $0.leading.equalTo(stickView.snp.trailing).offset(9.0)
            $0.trailing.equalToSuperview().offset(-22.0)
            $0.bottom.equalToSuperview()
        }
        
        exhibitTitleLabel.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(11.0)
            $0.trailing.lessThanOrEqualTo(reservationTimeLabel.snp.leading).offset(-6.0)
            $0.width.equalTo(140.0)
        }
        
        reservationTimeLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitTitleLabel.snp.top)
            $0.trailing.equalToSuperview().offset(-8.0)
        }
        
        stationLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitTitleLabel.snp.bottom).offset(10.0)
            $0.leading.equalTo(exhibitTitleLabel.snp.leading)
            $0.bottom.equalToSuperview().offset(-12.0)
        }
        
        visitBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-8.0)
            $0.centerY.equalTo(stationLabel.snp.centerY)
        }
    }
}
