//
//  UIFont+Extension.swift
//  FestFive
//
//  Created by Techchain on 26/02/2021.
//

import Foundation
import UIKit

extension UIFont {
    static func yoonGothic7(style: Int, size: CGFloat) -> UIFont {
        let name = "YOONGOTHIC7\(style)"
        let font = UIFont.init(name: name, size: size)
        guard let result = font else {
            fatalError("Missing Font: \(name)")
        }
        return result
    }
    
    static func font(with weight: Weight, size: CGFloat) -> UIFont {
        let name = "MavenPro"
        var font: UIFont?
        switch weight {
        case .bold:
            font = UIFont.init(name: "\(name)-Bold", size: size)
        case .regular:
            font = UIFont.init(name: "\(name)-Regular", size: size)
        case .medium:
            font = UIFont.init(name: "\(name)-Medium", size: size)
        default:
            font = UIFont.init(name: "\(name)-Regular", size: size)
        }
        guard let result = font else {
            fatalError("Missing Font: \(name)")
        }
        return result
    }
    
    var weight: UIFont.Weight {
        guard let face = fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.face) as? String else { return .regular }
        switch face {
        case "Medium":
            return .medium
        case "Bold":
            return .bold
        case "Regular":
            return .regular
        default:
            return .regular
        }
    }
}
