//
//  CustomPickerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/05.
//

import UIKit

class CustomPickerView: UIView {
    //MARK: - Properties
    var titles: [String] = [String]()
    var pickerType: PickerType?
    var delegate: ExhibitionTimeSelectViewDelegate?
    
    //MARK: UI Components
    lazy var pickerView = UIPickerView().then{
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .clear
    }
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        selectedPickerViewUICustom()
    }
    
    //MARK: - Functions
    func selectedPickerViewUICustom() {
        self.pickerView.subviews[1].backgroundColor = .clear
        
        let upLine = UIView()
        let underLine = UIView()
        
        upLine.backgroundColor = UIColor.Basic.gray03
        underLine.backgroundColor = UIColor.Basic.gray03
        
        self.pickerView.subviews[1].addSubview(upLine)
        self.pickerView.subviews[1].addSubview(underLine)
        
        upLine.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.8)
        }
        underLine.snp.makeConstraints{
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.8)
        }
    }
    
    //MARK: - Functions
    func config(titles: [String], type: PickerType){
        self.titles = titles
        self.pickerType = type
    }
    
    func setUI(){
        self.addSubview(pickerView)
        
        pickerView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

extension CustomPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    /* 피커뷰 몇개 들어갈지 */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /* 피커뷰에 들어갈 개수 */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let titleLabel = UILabel().then{
            $0.text = titles[row]
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = UIFont.TTFont(type: .MontSemiBold, size: 20)
        }
        
        let rowView = UIView().then{
            $0.backgroundColor = .clear
        }
        
        rowView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        return rowView
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    /* 피커뷰 선택되었을때 */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let delegate = self.delegate else {
            print("pickerView didSelectRow delegate is nil")
            return
        }
        delegate.setSelectedTitle(title: titles[row], type: self.pickerType!)
    }
}
