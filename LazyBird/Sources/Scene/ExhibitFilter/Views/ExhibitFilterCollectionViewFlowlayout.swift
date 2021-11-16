//
//  ExhibitFilterCollectionViewFlowlayout.swift
//  LazyBird
//
//  Created by 이숭인 on 2021/11/16.
//

import UIKit


class ExhibitFilterCollectionViewFlowlayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var attributeCopy = [UICollectionViewLayoutAttributes]()
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            let layoutAttributeCopy = layoutAttribute.copy() as! UICollectionViewLayoutAttributes
            if layoutAttributeCopy.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttributeCopy.frame.origin.x = leftMargin

            leftMargin += layoutAttributeCopy.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttributeCopy.frame.maxY , maxY)
            attributeCopy.append(layoutAttributeCopy)
        }

        return attributeCopy
    }
}
