//
//  ConfigKey.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import Foundation
struct ConfigKey {
    static let apiDomain = "API_DOMAIN"
    static let socketURL = "SOCKET_URL"
    static let environment = "ENVIRONMENT"
}

enum Environment: String {
    case development
    case stagging
    case production
    
    static var current: Environment = {
        let raw = ConfigKey.environment.configFromInfoPlist()
        guard let env = Environment(rawValue: raw) else {
            return .development
        }
        return env
    }()
}

extension String {
    func configFromInfoPlist() -> String {
        return (Bundle.main.infoDictionary?[self] as? String)?.replacingOccurrences(of: "\\", with: "") ?? ""
    }
}
