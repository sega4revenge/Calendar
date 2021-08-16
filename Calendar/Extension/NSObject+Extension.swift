//
//  NSObject+Extension.swift
//  FestFive
//
//  Created by Techchain on 05/03/2021.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
