//
//  String+Extension.swift
//  FestFive
//
//  Created by Techchain on 02/03/2021.
//

import Foundation
import UIKit
extension String {
    func localized() -> String {
        let language = "en"
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"), let bundle = Bundle(path: path) else {
            return self
        }
        return bundle.localizedString(forKey: self, value: self, table: nil)
    }

    func color() -> UIColor {
        var string: String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (string.hasPrefix("#")) {
            string.remove(at: string.startIndex)
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: string).scanHexInt32(&rgbValue)

        return UIColor.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    func dateFromServer(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.date(from: self)
    }
    
    var image: UIImage {
        return UIImage(named: self) ?? UIImage()
    }
    
    func imageSize() -> CGSize? {
        guard let url = URL(string: self),
            let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
            return nil
        }
        let propertiesOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, propertiesOptions) as? [CFString: Any] else {
            return nil
        }
        if let width = properties[kCGImagePropertyPixelWidth] as? CGFloat,
           let height = properties[kCGImagePropertyPixelHeight] as? CGFloat {
            return CGSize(width: width, height: height)
        } else {
            return nil
        }
    }
    
    func htmlAttributedString(fontSize: CGFloat = 17.0, color: UIColor? = nil, alignment: NSTextAlignment = .natural) -> NSMutableAttributedString {
        var style = "<style>body{font-family: '%@'; font-size:%fpx;}</style>"
        let fontName = UIFont.yoonGothic7(style: 70, size: fontSize)
        switch alignment {
        case .left:
            style = "<style>body{font-family: '%@'; font-size:%fpx; text-align: left;}</style>"
        case .center:
            style = "<style>body{font-family: '%@'; font-size:%fpx; text-align: center;}</style>"
        case .right:
            style = "<style>body{font-family: '%@'; font-size:%fpx; text-align: right;}</style>"
        case .justified:
            style = "<style>body{font-family: '%@'; font-size:%fpx; text-align: justify;}</style>"
        case .natural: break
        @unknown default: break
        }
        let string = appending(String(format: style, fontName, fontSize))
        guard let data = string.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return NSMutableAttributedString() }
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        guard let html = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) else {
            return NSMutableAttributedString()
        }
        
        if let color = color {
            let range = NSRange(location: 0, length: html.length)
            html.addAttributes([.foregroundColor: color], range: range)
        }
        return html
    }
}
