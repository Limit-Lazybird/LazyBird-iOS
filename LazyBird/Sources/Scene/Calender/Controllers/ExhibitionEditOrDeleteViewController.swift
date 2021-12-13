//
//  ExhibitionEditOrDeleteViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/13.
//

import UIKit

class ExhibitionEditOrDeleteViewController: UIViewController {
    //MARK: - Properties
    var currentSchedule: Schedule?
    var currentIndex: Int?
    var delegate: CalendarViewDelegate?
    
    //MARK: - UI Components
    lazy var bgView = UIView().then{
        $0.backgroundColor = UIColor.Opacity.black80
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(bgViewPressed(_:))))
    }
    
    let alertBgView = UIView().then{
        $0.backgroundColor = UIColor.Background.darkGray02
        $0.layer.cornerRadius = 10
    }
    
    lazy var editBtn = UIButton().then{
        $0.setTitle("수정", for: .normal)
        $0.backgroundColor = UIColor.Basic.gray01
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(editBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var deleteBtn = UIButton().then{
        $0.setTitle("삭제", for: .normal)
        $0.backgroundColor = UIColor.Basic.gray01
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(deleteBtnPressed(_:)), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        setUI()
    }
    
    //MARK: - Functions
    @objc func bgViewPressed(_ sender: UITapGestureRecognizer){
        //TODO: 화면 dismiss
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func editBtnPressed(_ sender: UIButton){
        //TODO: 화면 dismiss
        print("edit")
        self.dismiss(animated: false){
            self.delegate?.moveToAddExhibitionScheduleForEdit(schedule: self.currentSchedule!)
        }
    }
    
    @objc func deleteBtnPressed(_ sender: UIButton){
        //TODO: 일정 삭제 request
        print("delete")
        self.dismiss(animated: false){
            //TODO: 일정 삭제 request 하기
            if self.currentSchedule!.isCustom!{
                print("커스텀 삭제지롱 0--=-")
                self.delegate?.deleteCustomSchedule(schedule: self.currentSchedule!)
            }else{
                print("예약된 전시 삭제지롱 0--=-")
                self.delegate?.deleteBookedSchedule(schedule: self.currentSchedule!)
            }
            
        }
    }
    
    func setUI(){
        self.view.addSubview(bgView)
        self.view.addSubview(alertBgView)
        alertBgView.addSubview(editBtn)
        alertBgView.addSubview(deleteBtn)
        
        
        bgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        alertBgView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(42.0)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-42.0)
            $0.height.equalTo(146.0)
        }
        
        editBtn.snp.makeConstraints{
            $0.top.equalTo(alertBgView.snp.top).offset(20.0)
            $0.leading.equalTo(alertBgView.snp.leading).offset(20.0)
            $0.trailing.equalTo(alertBgView.snp.trailing).offset(-20.0)
            $0.height.equalTo(48.0)
        }
        
        deleteBtn.snp.makeConstraints{
            $0.top.equalTo(editBtn.snp.bottom).offset(10.0)
            $0.leading.equalTo(alertBgView.snp.leading).offset(20.0)
            $0.trailing.equalTo(alertBgView.snp.trailing).offset(-20.0)
            $0.height.equalTo(48.0)
        }
    }
}
