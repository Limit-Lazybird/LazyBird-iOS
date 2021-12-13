//
//  UIViewExtension.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/10/30.
//

import UIKit

extension UIView{
    func setGradient(color1: UIColor, color2: UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.4, b: -1.24, c: 1.24, d: 11.46, tx: -0.52, ty: -5.4))
        gradient.bounds = self.bounds.insetBy(dx: -0.5 * self.bounds.size.width,
                                              dy: -0.5 * self.bounds.size.height)
        gradient.position = self.center
        self.layer.addSublayer(gradient)
    }
    
    func transfromToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer {
            UIGraphicsEndImageContext()
        }
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        return nil
    }
}
