//
//  AppDelegate.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/18.
//

import UIKit
import KakaoSDKCommon
import AuthenticationServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        KakaoSDKCommon.initSDK(appKey: "ed1671c07f7f99c3ad5e2640429b8dab")
        
        // 바텀 탭바 iOS 15 대응
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            let tabBar = UITabBar()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.Background.black02
            tabBar.standardAppearance = appearance;
//            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        // 네비게이션바 iOS 15 대응
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.Background.black02
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        // 세로로 고정
        return UIInterfaceOrientationMask.portrait
    }


}

