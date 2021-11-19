//
//  ExhibitContentContainerView.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/10.
//

import UIKit
import SnapKit
import Then
import Kingfisher

/*
 1. content 이미지 뷰인데 이걸 어떻게 해야할지 좀 고민을 해봐야할거같음 어쩌지???
 */

class ExhibitContentContainerView: UIView {
    //MARK: - Properties
    var viewModel: ExhibitDetailViewModel?
    
    //MARK: - UI Components
    let imageBackgroundView = UIView().then{
        $0.backgroundColor = .darkGray
    }
    
    let contentImageView = UIImageView().then{
        $0.contentMode = .top
        $0.clipsToBounds = true
    }
    
    lazy var moreBtn = UIButton().then{
        $0.backgroundColor = UIColor.Basic.black01
        $0.setTitle("상세정보 더보기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 11)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.white.cgColor
        $0.addTarget(self, action: #selector(moreBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var contentStackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 0.0
        $0.addArrangedSubview(imageBackgroundView)
        $0.addArrangedSubview(moreBtn)
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
    @objc func moreBtnPressed(_ sender: UIButton){
        moreBtn.isSelected = !moreBtn.isSelected
        
        if moreBtn.isSelected {
            expendHeight() // 확장
        }else{
            reduceHeight() // 축소
        }
    }
    
    func config(viewModel: ExhibitDetailViewModel, frame: CGRect){
        self.viewModel = viewModel
        guard let vm = self.viewModel else { return }
        
        let exhibit = vm.getExhibit().value
        self.contentImageView.kf.setImage(with: URL(string: exhibit.dt_img ?? "")) { result in
            switch result{
            case .success:
                self.contentImageView.image = self.contentImageView.image?.resize(newWidth: frame.width)
            case .failure(let error):
                print("error -> \(error.localizedDescription)")
            }
        }
    }
    
    func setUI(){
        self.addSubview(contentStackView)
        imageBackgroundView.addSubview(contentImageView)
        
        contentStackView.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(16.0)
            $0.trailing.bottom.equalToSuperview().offset(-16.0)
        }
        
        contentImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        imageBackgroundView.snp.makeConstraints{
            $0.height.equalTo(300.0)
        }
        
        moreBtn.snp.makeConstraints{
            $0.height.equalTo(40.0)
        }
    }
    
    // content image 확장
    func expendHeight() {
        if let height = self.contentImageView.image?.size.height{
            self.imageBackgroundView.snp.remakeConstraints {
                $0.height.equalTo(height)
            }
        }
    }
    
    // content image 축소
    func reduceHeight() {
        self.imageBackgroundView.snp.remakeConstraints {
            $0.height.equalTo(300.0)
        }
    }
}
