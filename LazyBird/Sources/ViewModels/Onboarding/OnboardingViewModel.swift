//
//  OnboardingViewModel.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/25.
//

import UIKit

class OnboardingViewModel {
    private let onboardAPIManager = OnboardingAPIManager.shared // api manager
    let onboardManager = OnboardManager.shared // 받아온 질문리스트, 보낼 선택리스트 저장
    
    func requestOnboardQuestions(){
        onboardAPIManager.requestOnboardQuestions { analysisQuestions in
            //TODO: 싱글턴객체에 값 저장하고 끝.
            for question in analysisQuestions.questions{
                self.onboardManager.addAnalysisResult(result: question.cs_head)
            }
        }
    }
    
    func requestQuestionAnswer(){
        let arrToStr = onboardManager.getUserInput().map{ String($0) }.joined(separator: ".")
        print("arr To Str --> \(arrToStr)")
        onboardAPIManager.requestQuestionAnswer(userInput: arrToStr)
    }
}
