//
//  MyBirdReservedExhibitionView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit
import SnapKit
import Then

class MyBirdReservedExhibitionView: UIView {
    //MARK: - Properties
    var delegate: MyBirdViewControllerProtocol?
    
    //MARK: - UI Components
    let ticketingTitleLabel = UILabel().then{
        $0.text = "예매한 전시"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = .white
    }
    
    let noResultLabel = UILabel().then{
        $0.text = "예매한 전시가 없어요."
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.Basic.gray03
    }
    
    lazy var moreBtn = UIButton().then{
        $0.setImage(UIImage(named: "ic_expand_light"), for: .normal)
        $0.addTarget(self, action: #selector(moreBtnPressed(_:)), for: .touchUpInside)
    }
    
    let leftExhibitPreview = MyBirdExhibitPreview()
    let rightExhibitPreview = MyBirdExhibitPreview()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.Background.darkGray02
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(moveToDetail(_:))))
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Functions
    @objc func moveToDetail(_ sender: Any){
        self.delegate?.moveToReservedExhibitDetail()
    }
    
    @objc func moreBtnPressed(_ sender: UIButton){
        self.delegate?.moveToReservedExhibitDetail()
    }
    
    func config(exhibit: [Exhibit]){
        switch exhibit.count{
        case 0:
            print("값이 하나도 없습니당")
            self.noResultLabel.isHidden = false
            self.leftExhibitPreview.config(exhibit: nil)
            self.rightExhibitPreview.config(exhibit: nil)
            break
        case 1:
            self.noResultLabel.isHidden = true
            self.leftExhibitPreview.config(exhibit: exhibit[0])
            self.rightExhibitPreview.config(exhibit: nil)
            break
        case 2:
            self.noResultLabel.isHidden = true
            self.leftExhibitPreview.config(exhibit: exhibit[0])
            self.rightExhibitPreview.config(exhibit: exhibit[1])
            break
        default:
            self.noResultLabel.isHidden = true
            self.leftExhibitPreview.config(exhibit: exhibit[0])
            self.rightExhibitPreview.config(exhibit: exhibit[1])
            print("두개 이상이니까 그냥 다")
        }
    }
    
    func setUI(){
        self.addSubview(ticketingTitleLabel)
        self.addSubview(moreBtn)
        self.addSubview(leftExhibitPreview)
        self.addSubview(rightExhibitPreview)
        self.addSubview(noResultLabel)
        
        ticketingTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        moreBtn.snp.makeConstraints{
            $0.centerY.equalTo(ticketingTitleLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.width.height.equalTo(24.0)
        }

        leftExhibitPreview.snp.makeConstraints{
            $0.top.equalTo(ticketingTitleLabel.snp.bottom).offset(27.0)
            $0.leading.equalToSuperview().offset(28.0)
            $0.bottom.equalToSuperview().offset(-28.0)
        }
        
        rightExhibitPreview.snp.makeConstraints{
            $0.top.equalTo(leftExhibitPreview.snp.top)
            $0.leading.equalTo(leftExhibitPreview.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().offset(-28.0)
            $0.width.equalTo(leftExhibitPreview.snp.width)
        }
        
        noResultLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
}
