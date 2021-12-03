//
//  CalendarCustomTextField.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/12/03.
//

import UIKit

class CalendarCustomTextField: UITextField {

    @IBInspectable var inset: UIEdgeInsets = UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16)
    
    // 얘는 뭐냐 왜 안되냐??
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
    
    // 얘가 유저 인풋 텍스트 inset 정하는듯
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
    
    // placeholder inset 정하는듯
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }

}
