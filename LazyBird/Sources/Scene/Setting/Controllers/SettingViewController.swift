//
//  SettingViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/26.
//

import UIKit
import SnapKit
import Then

enum settingType{
    case reset
    case notice
    case termOfUse
    case privacy
    case logout
    case withdrawal
}

protocol SettingViewControllerProtocol{
    func moveToDetail(type: settingType)
}

class SettingViewController: UIViewController {
    
    //MARK: - UI Components
    lazy var resettingView = SettingItemView().then{
        $0.delegate = self
        $0.setType = .reset
    }
    lazy var noticeView = SettingItemView().then{
        $0.delegate = self
        $0.setType = .notice
    }
    lazy var termOfUseView = SettingItemView().then{
        $0.delegate = self
        $0.setType = .termOfUse
    }
    lazy var privacyPolicy = SettingItemView().then{
        $0.delegate = self
        $0.setType = .privacy
    }
    lazy var logoutView = SettingItemView().then{
        $0.delegate = self
        $0.setType = .logout
    }
    lazy var withdrawalView = SettingItemView().then{
        $0.delegate = self
        $0.setType = .withdrawal
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Background.black02
        
        setUI()
        setNavigationItem()
        setConfig()
    }
    
    //MARK: - Functions
    func setConfig(){
        resettingView.config(text: "성향분석 재설정")
        noticeView.config(text: "공지사항")
        termOfUseView.config(text: "이용약관")
        privacyPolicy.config(text: "개인정보 처리방침")
        logoutView.config(text: "로그아웃")
        withdrawalView.config(text: "회원 탈퇴")
    }
    
    func setNavigationItem(){
        self.navigationItem.title = "설정"
        self.navigationController?.navigationBar.shadowImage = colorToImage()
        // Title 설정
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.Background.black02
        self.navigationController?.navigationBar.isTranslucent = false
        // navigationbar backbutton 설정
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_arrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_arrow")
    }
    
    func setUI(){
        self.view.addSubview(resettingView)
        self.view.addSubview(noticeView)
        self.view.addSubview(termOfUseView)
        self.view.addSubview(privacyPolicy)
        self.view.addSubview(logoutView)
        self.view.addSubview(withdrawalView)
        
        resettingView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        
        noticeView.snp.makeConstraints{
            $0.top.equalTo(resettingView.snp.bottom).offset(16.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        
        termOfUseView.snp.makeConstraints{
            $0.top.equalTo(noticeView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        
        privacyPolicy.snp.makeConstraints{
            $0.top.equalTo(termOfUseView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        
        logoutView.snp.makeConstraints{
            $0.top.equalTo(privacyPolicy.snp.bottom).offset(16.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        
        withdrawalView.snp.makeConstraints{
            $0.top.equalTo(logoutView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.0)
        }
    }
    
    private func colorToImage() -> UIImage {
        let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        let image: UIImage = UIGraphicsImageRenderer(size: size).image { context in
            UIColor.Background.black02.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        return image
    }
}

extension SettingViewController: SettingViewControllerProtocol{
    func moveToDetail(type: settingType) {
        switch type {
        case .reset: // 성향분석 재설정
            let resetOnboardingVC = ResetOnboardAlertViewController()
            resetOnboardingVC.modalPresentationStyle = .overFullScreen
            
            self.present(resetOnboardingVC, animated: true, completion: nil)
        case .notice: // 공지사항
            let noticeVC = NoticeViewController()
            self.navigationController?.pushViewController(noticeVC, animated: true)
        case .termOfUse: // 약관
            let termOfUseVC = TermOfUseViewController()
            self.navigationController?.pushViewController(termOfUseVC, animated: true)
        case .privacy: // 개인정보처리방침
            let privacyVC = PrivacyViewController()
            self.navigationController?.pushViewController(privacyVC, animated: true)
        case .logout: // 로그아웃
            print("로그아웃")
            let logoutVC = LogoutAlertViewController()
            logoutVC.modalPresentationStyle = .overFullScreen
            self.present(logoutVC,animated: true, completion: nil)
        case .withdrawal: // 회원탈퇴
            print("회원탈퇴")
            let withoutVC = WithdrawalViewController()
            withoutVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(withoutVC, animated: true)
        }
    }
}
