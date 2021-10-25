//
//  AppleLoginManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/20.
//

import UIKit
import AuthenticationServices

class AppleLoginManager: NSObject {
    private var vc: UIViewController?
    
    // Apple Login Button Pressed
    func login(){
        guard let vc = self.vc else { return }
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
            
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = vc as? LoginViewController
        authorizationController.presentationContextProvider = vc as? LoginViewController
        authorizationController.performRequests()
    }
}

extension AppleLoginManager {
    func setViewController(_ vc: UIViewController?){
        self.vc = vc
    }
}
