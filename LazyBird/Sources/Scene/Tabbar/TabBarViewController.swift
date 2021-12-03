//
//  TabbarViewController.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/27.
//

import UIKit
import SnapKit
import Then

class TabBarViewController: UITabBarController {
    lazy var earlybirdVC = EarlyBirdViewController().then{
        $0.tabBarItem = UITabBarItem(title: "얼리버드",
                                     image: UIImage(named: "earlybirdOff"),
                                     selectedImage: UIImage(named: "earlybirdOn")?.withRenderingMode(.alwaysOriginal))
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    let exhibitVC = ExhibitViewController().then{
        $0.tabBarItem = UITabBarItem(title: "전시",
                                     image: UIImage(named: "dashboardOff"),
                                     selectedImage: UIImage(named: "dashboardOn")?.withRenderingMode(.alwaysOriginal))
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    let calenderVC = CalendarViewController().then{
        $0.tabBarItem = UITabBarItem(title: "캘린더",
                                     image: UIImage(named: "calendarOff"),
                                     selectedImage: UIImage(named: "calendarOn")?.withRenderingMode(.alwaysOriginal))
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    let searchVC = ExhibitSearchViewController().then{
        $0.tabBarItem = UITabBarItem(title: "검색",
                                     image: UIImage(named: "searchOff"),
                                     selectedImage: UIImage(named: "searchOn")?.withRenderingMode(.alwaysOriginal))
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    let mybirdVC = MyBirdViewController().then{
        $0.tabBarItem = UITabBarItem(title: "마이버드",
                                     image: UIImage(named: "mybirdOff"),
                                     selectedImage: UIImage(named: "mybirdOn")?.withRenderingMode(.alwaysOriginal))
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabbarUI()
        setTabBarLink()
    }
    
    private func setTabbarUI(){
        tabBar.tintColor = UIColor.white
        tabBar.barTintColor = UIColor.Background.black02
        tabBar.unselectedItemTintColor = UIColor.Basic.gray04
        tabBar.isTranslucent = false
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.borderWidth = 1.0
        tabBar.layer.cornerRadius = 20.0
        tabBar.layer.borderColor = UIColor.Basic.gray03.cgColor
        // tabbar shadow 지우기
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
//        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    private func setTabBarLink() {
        let earlybiard = UINavigationController(rootViewController: earlybirdVC)
        let exhibit = UINavigationController(rootViewController: exhibitVC)
        let calender = UINavigationController(rootViewController: calenderVC)
        let search = UINavigationController(rootViewController: searchVC)
        let mybird = UINavigationController(rootViewController: mybirdVC)
        viewControllers = [earlybiard,
                           exhibit,
                           calender,
                           search,
                           mybird]
        
    }
}
