//
//  Color.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import Foundation
import UIKit
extension UIColor {
    enum Source: String {
        case colorF7F8FC = "F7F8FC"
        case color7B7E91 = "7B7E91"
        case color7470EF = "7470EF"
        case colorFF5E5E = "FF5E5E"
        case color1E0A3C = "1E0A3C"
        
    }
    
    static let colorF7F8FC = UIColor(source: .colorF7F8FC)
    static let color7B7E91 = UIColor(source: .color7B7E91)
    static let color7470EF = UIColor(source: .color7470EF)
    static let colorFF5E5E = UIColor(source: .colorFF5E5E)
    static let color1E0A3C = UIColor(source: .color1E0A3C)
}
