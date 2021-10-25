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
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        print("appDelegate")
//        // 애플 자동 로그인
//
//
//        appleIDProvider.getCredentialState(forUserID: "apple id credential") { (credentialState, error) in
//            switch credentialState {
//            case .authorized:
//                // The Apple ID credential is valid.
//                print("해당 ID는 연동되어있습니다.")
//                break
//            case .revoked:
//                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
//                print("해당 ID는 연동되어있지않습니다.")
//                break
//            case .notFound:
//                // The Apple ID credential is either was not found, so show the sign-in UI.
//                print("해당 ID를 찾을 수 없습니다.")
//                break
//            default:
//                break
//            }
//        }
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


}

