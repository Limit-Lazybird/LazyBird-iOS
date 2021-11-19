//
//  ExhibitGuideContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/10.
//

import UIKit
import SnapKit
import Then

/*
 ∙•・
 1. 알림 라벨
 2. 티켓 판매기간 알림 라벨
 3. 주의할점 라벨 -> 이부분은 몇개인지 모르니까 음,, 코드적으로 라벨을 만들고, 그 내용을 채우는 식으로 해야할듯. 레이아웃은 일단 스택뷰 만들어놓고 거기에 넣는 식으로 하면 되지 않을까앂음
 */

class ExhibitGuideContainerView: UIView {
    //MARK: - Properties
    var viewModel: ExhibitDetailViewModel?
    
    fileprivate let changeStrFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter
    }()
    
    fileprivate let changeStrFormatterTwo: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "얼리버드 티켓은 M월 d일까지 판매됩니다."
        return dateFormatter
    }()

    //MARK: - UI Components
    
    let warningLabel = UILabel().then{
        $0.text = "전시회 예매 전 확인하세요."
        $0.font = UIFont.TTFont(type: .SDBold, size: 13)
        $0.textColor = UIColor.Point.or01
    }
    
    let alertLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = .white
    }
    
    lazy var messageStackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 4.0
    }
    
    //MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.Background.black02
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func config(viewModel: ExhibitDetailViewModel){
        self.viewModel = viewModel
        guard let vm = self.viewModel else { return }
        
        let exhibit = vm.getExhibit().value
        let notices = exhibit.exhbt_notice?.components(separatedBy: ".") ?? []
        
        alertLabel.text = getExhibitDateTwo(date: exhibit.exhbt_to_dt ?? "")
        
        for notice in notices{
            let messageLabel = UILabel().then{
                $0.text = "• \(notice)"
                $0.font = UIFont.TTFont(type: .SDReg, size: 13)
                $0.numberOfLines = 5
                $0.textColor = .white
            }
            messageStackView.addArrangedSubview(messageLabel)
        }
    }
    
    func setBind(){
        guard let viewModel = viewModel else {
            print("viewModel is nil")
            return
        }
        let exhibit = viewModel.getExhibit().value
        let notices = exhibit.exhbt_notice?.components(separatedBy: ".") ?? []
        
        alertLabel.text = getExhibitDateTwo(date: exhibit.exhbt_to_dt ?? "")
        
        for notice in notices{
            let messageLabel = UILabel().then{
                $0.text = "• \(notice)"
                $0.font = UIFont.TTFont(type: .SDReg, size: 13)
                $0.numberOfLines = 5
                $0.textColor = .white
            }
            messageStackView.addArrangedSubview(messageLabel)
        }
    }
    
    private func getExhibitDate(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date: Date = dateFormatter.date(from: date){
            return changeStrFormatter.string(from: date)
        }
        
        return ""
    }
    private func getExhibitDateTwo(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date: Date = dateFormatter.date(from: date){
            return changeStrFormatterTwo.string(from: date)
        }
        
        return ""
    }
    
    func setUI(){
        self.addSubview(warningLabel)
        self.addSubview(alertLabel)
        self.addSubview(messageStackView)
        
        warningLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(14.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        alertLabel.snp.makeConstraints{
            $0.top.equalTo(warningLabel.snp.bottom).offset(13.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        messageStackView.snp.makeConstraints{
            $0.top.equalTo(alertLabel.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-20.0)
        }
    }

}
