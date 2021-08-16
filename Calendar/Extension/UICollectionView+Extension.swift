//
//  UICollectionView+Extension.swift
//  FestFive
//
//  Created by Thinh Le on 3/20/21.
//

import Foundation
import UIKit

extension UICollectionView {
    func centerIndexPath() -> IndexPath? {
        let centerPoint = CGPoint(x: bounds.width / 2 + contentOffset.x, y: bounds.height / 2 + contentOffset.y)
        return indexPathForItem(at: centerPoint)
    }
}
