//
//  SceneDelegate.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/18.
//

import UIKit
import KakaoSDKAuth
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let kakaoLoginManager = KakaoLoginManager()
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene) // SceneDelegate의 프로퍼티에 설정해줌
        
        kakaoLoginManager.autoLogin { response in
            if response {
                //TODO: Login 성공
            }
        }
        let mainViewController = LoginViewController() // 맨 처음 보여줄 ViewController

        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
        
        // 자동 로그인
//        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
//            if error != nil || user == nil {
//                print("로그인 안 한 상태 -> 로그인 화면으로 이동")
//                let viewController = ViewController()
//                self.window?.rootViewController = viewController
//                self.window?.makeKeyAndVisible()
//                
//            } else {
//                print("이미 로그인 됨 -> 메인으로 이동")
//                
//                user?.authentication.do { authentication, error in
//                    guard error == nil else { return }
//                    guard let authentication = authentication else { return }
////                    token 을 서버로 보내주기
//                    authentication.idToken
//                }
//
//                let homeViewController = HomeViewController()
//                self.window?.rootViewController = homeViewController
//                self.window?.makeKeyAndVisible()
//            }
//          }

        
        // 나중에 분기를 만들자.
        // 자동 로그인 성공이라면, homeVC
        // 로그인 상태가 아니라면, LoginVC
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

