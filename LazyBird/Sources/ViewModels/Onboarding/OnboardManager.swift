//
//  OnboardManager.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit

//TODO: 선택한 버튼의 정보들 저장할 배열 저장
//TODO: Starting에서 Onboarding 에대한 정보를 받아와 저장

class OnboardManager {
    static let shared = OnboardManager()
    
    private init() { }
    
    private var analysisResult: [String] = [String]()
    private var userInput: [Int] = [Int]()
    
    func getAnalysisResult() -> [String]{
        return self.analysisResult
    }
    
    func getUserInput() -> [Int]{
        return self.userInput
    }
    
    func addAnalysisResult(result: String){
        self.analysisResult.append(result)
    }
    func addUserInput(input: Int){
        self.userInput.append(input)
    }
    
}
