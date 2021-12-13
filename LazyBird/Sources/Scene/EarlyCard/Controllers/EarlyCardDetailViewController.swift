//
//  EarlyCardDetailViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/14.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class EarlyCardDetailViewController: UIViewController {
    //MARK: - Properties
    var currentCard: EarlyCard?
    
    //MARK: - UI Components
    lazy var bgView = UIView().then{
        $0.backgroundColor = .black.withAlphaComponent(0.8)
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(bgViewPressed(_:))))
    }
    
    let cardBgView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 18.0
    }
    
    let thumbnailImageView = UIImageView().then{
        $0.contentMode = .top
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 18.0
    }
    
    let circleView = UIView().then{
        $0.backgroundColor = UIColor.Opacity.black80
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 46 / 2
    }
    
    let circleViewTwo = UIView().then{
        $0.backgroundColor = UIColor.Opacity.black80
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 46 / 2
    }
    
    let dashLineImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.image = UIImage(named: "dash_line")
    }
    
    let numberLabel = UILabel().then{
        $0.text = "NO.X"
        $0.font = UIFont.TTFont(type: .MontBold, size: 24)
        $0.textColor = UIColor.Point.or01
    }
    
    let exhibitTitleLabel = UILabel().then{
        $0.text = "aaasdad"
        $0.font = UIFont.TTFont(type: .SDBold, size: 24)
        $0.textColor = UIColor.Background.black02
    }
    
    let visitAlertLabel = UILabel().then{
        $0.text = "관람"
        $0.font = UIFont.TTFont(type: .SDBold, size: 24)
        $0.textColor = UIColor.Background.black02
    }
    
    let visitLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .SDReg, size: 24)
        $0.textColor = UIColor.Background.black02
    }
    
    let bubbleImageView = UIImageView().then{
        $0.image = UIImage(named: "earlycard_bubble")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    lazy var importBtn = UIButton().then{
        $0.setImage(UIImage(named: "import"), for: .normal)
        $0.addTarget(self, action: #selector(importBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var closeBtn = UIButton().then{
        $0.setImage(UIImage(named: "ic_close"), for: .normal)
        $0.addTarget(self, action: #selector(closeBtnPressed(_:)), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        setUI()
        setBind()
    }
    
    //MARK: - Functions\
    @objc func setImage(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
           //사진 저장 한후
           if let error = error {
               // we got back an error!
            print("에러처리 아몰랑 ~ \(error.localizedDescription)")
           } else {
                // save
               //TODO: 저장이 완료되어씀니다
               completeAlert()
           }
    }
    
    @objc func importBtnPressed(_ sender: UIButton){
        print("import Btn pressed")
        //TODO: 사진 캡쳐해야함
        guard let image = self.cardBgView.transfromToImage() else {
            print("EarlyCardDetailViewController importBtnPressed image is nil")
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(setImage(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func closeBtnPressed(_ sender: UIButton){
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func bgViewPressed(_ sender: UIButton){
        self.dismiss(animated: false, completion: nil)
    }
    
    func completeAlert(){
        let alert = UIAlertController(title: "저장 성공", message: "갤러리에 사진을 성공적으로 저장하였습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { (ok) in
            
        }
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setBind(){
        guard let currentCard = currentCard else {
            print("EarlyCardDetailViewController setBind currentCard is nil")
            return
        }

        self.numberLabel.text = "NO.\(currentCard.early_num)"
        self.exhibitTitleLabel.text = currentCard.exhbt_nm
        self.visitLabel.text = currentCard.early_rg_dt
//
        thumbnailImageView.kf.setImage(with: URL(string: currentCard.exhbt_sn)){ result in
            switch result{
            case .success:
                let newWidth: CGFloat = self.view.frame.width - (26.0 * 2) - (24.0 * 2)
                self.thumbnailImageView.image = self.thumbnailImageView.image?.resize(newWidth: newWidth)
            case .failure(let error):
                print("error -> \(error.localizedDescription)")
            }
        }
    }
    
    func setUI(){
        self.view.addSubview(bgView)
        self.view.addSubview(bubbleImageView)
        self.view.addSubview(importBtn)
        self.view.addSubview(closeBtn)
        self.view.addSubview(cardBgView)
        cardBgView.addSubview(thumbnailImageView)
        cardBgView.addSubview(circleView)
        cardBgView.addSubview(circleViewTwo)
        cardBgView.addSubview(dashLineImageView)
        cardBgView.addSubview(numberLabel)
        cardBgView.addSubview(exhibitTitleLabel)
        cardBgView.addSubview(visitAlertLabel)
        cardBgView.addSubview(visitLabel)
        
        bgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        bubbleImageView.snp.makeConstraints{
            $0.trailing.equalTo(importBtn.snp.trailing).offset(10.0)
            $0.bottom.equalTo(importBtn.snp.top).offset(-3.0)
            $0.width.equalTo(146.0)
            $0.height.equalTo(33.0)
        }
        
        importBtn.snp.makeConstraints{
            $0.trailing.equalTo(closeBtn.snp.leading).offset(-16.0)
            $0.bottom.equalTo(cardBgView.snp.top).offset(-16.0)
            $0.width.height.equalTo(30.0)
        }
        
        closeBtn.snp.makeConstraints{
            $0.trailing.equalTo(cardBgView.snp.trailing)
            $0.bottom.equalTo(cardBgView.snp.top).offset(-16.0)
            $0.width.height.equalTo(30.0)
        }
        
        cardBgView.snp.makeConstraints{
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(26.0)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-26.0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-26.0)
            $0.height.equalTo(self.view.frame.height * 0.7)
        }
        
        thumbnailImageView.snp.makeConstraints{
            $0.top.equalTo(cardBgView.snp.top).offset(24.0)
            $0.leading.equalTo(cardBgView.snp.leading).offset(24.0)
            $0.trailing.equalTo(cardBgView.snp.trailing).offset(-24.0)
            $0.bottom.equalTo(dashLineImageView.snp.top).offset(-36.0)
        }
        
        circleView.snp.makeConstraints{
            $0.centerY.equalTo(cardBgView.snp.centerY).multipliedBy(1.4)
            $0.centerX.equalTo(cardBgView.snp.leading).offset(-4.0)
            $0.width.height.equalTo(46.0)
        }
        
        circleViewTwo.snp.makeConstraints{
            $0.centerY.equalTo(cardBgView.snp.centerY).multipliedBy(1.4)
            $0.centerX.equalTo(cardBgView.snp.trailing).offset(4.0)
            $0.width.height.equalTo(46.0)
        }
        
        dashLineImageView.snp.makeConstraints{
            $0.centerY.equalTo(circleView.snp.centerY)
            $0.leading.equalTo(circleView.snp.trailing).offset(20.0)
            $0.trailing.equalTo(circleViewTwo.snp.leading).offset(-20.0)
            $0.height.equalTo(5.0)
        }
        
        numberLabel.snp.makeConstraints{
            $0.top.equalTo(dashLineImageView.snp.bottom).offset(21.0)
            $0.leading.equalTo(cardBgView.snp.leading).offset(21.0)
        }
        
        exhibitTitleLabel.snp.makeConstraints{
            $0.top.equalTo(numberLabel.snp.bottom).offset(10.0)
            $0.leading.equalTo(cardBgView.snp.leading).offset(21.0)
            $0.trailing.equalTo(cardBgView.snp.trailing).offset(-21.0)
        }
        
        visitAlertLabel.snp.makeConstraints{
            $0.top.equalTo(exhibitTitleLabel.snp.bottom).offset(10.0)
            $0.leading.equalTo(cardBgView.snp.leading).offset(21.0)
        }
        
        visitLabel.snp.makeConstraints{
            $0.leading.equalTo(visitAlertLabel.snp.trailing).offset(4.0)
            $0.centerY.equalTo(visitAlertLabel.snp.centerY)
        }
    }
}
