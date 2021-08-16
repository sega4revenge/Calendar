//
//  UIColor+Extension.swift
//  FestFive
//
//  Created by Techchain on 25/02/2021.
//

import UIKit

extension UIColor {
    convenience init(source: Source) {
        self.init(named: source.rawValue)!
    }
}


extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
    
    convenience init(_ hex: String) {
        var string: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (string.hasPrefix("#")) {
            string.remove(at: string.startIndex)
        }

        if (string.count != 6) {
            self.init()
            return
        }

        var rgbValue: UInt32 = 0
        Scanner(string: string).scanHexInt32(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
