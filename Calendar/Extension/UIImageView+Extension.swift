//
//  UIImageView+Extension.swift
//  FestFive
//
//  Created by Techchain on 05/03/2021.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func setImage(from urlString: String?, placeHolder image: UIImage? = nil) {
        guard let string = urlString, let url = URL(string: string) else {
            self.image = UIImage(named: "img_default")
            return
        }
        
        let lastPath = url.lastPathComponent
        let imageCache = ImageCache.init(name: "calendar")
        
        let resource = ImageResource(downloadURL: url, cacheKey: lastPath)
        
        let option: KingfisherOptionsInfo = [
            .targetCache(imageCache),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage,
            .keepCurrentImageWhileLoading
        ]
        
        kf.setImage(
            with: resource,
            placeholder: UIImage(named: "img_default"),
            options: option)
    }
    
    func makeRounded(_ borderWidth: CGFloat = 1,_ borderColor: CGColor = UIColor.white.cgColor) {
        layer.borderWidth = borderWidth
        layer.masksToBounds = false
        layer.borderColor = borderColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
