//
//  UIFontExtension.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/14.
//

import UIKit

enum FontType {
    case MontBold, MontMed, MontSemiBold, MontReg, SDBold, SDMed, SDReg, SDHeader
}

extension UIFont {
    static func TTFont(type: FontType, size: CGFloat) -> UIFont {
        var fontName = ""
        switch type {
        case .MontBold:
            fontName = "Montserrat-BOLD"
        case .MontMed:
            fontName = "Montserrat-MEDIUM"
        case .MontSemiBold:
            fontName = "Montserrat-SemiBold"
        case .MontReg:
            fontName = "Montserrat-Regular"
        case .SDBold:
            fontName = "AppleSDGothicNeo-Bold"
        case .SDMed:
            fontName = "AppleSDGothicNeo-Medium"
        case .SDReg:
            fontName = "AppleSDGothicNeo-Regular"
        case .SDHeader:
            fontName = "AppleSDGothicNeo-BOLD"
        }
        
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
