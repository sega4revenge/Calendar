//
//  CalendarTarget.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import Foundation
import Alamofire

enum CalendarTarget {
    case getWorkouts
}

extension CalendarTarget: Target {
    var preloadCache: Bool {
        switch self {
        case .getWorkouts: return true
        }
    }
    
    var path: String {
        switch self {
        case .getWorkouts: return ApiPath.apiDomain / "workouts"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getWorkouts: return .get
        }
    }

    var params: Parameters? {
        switch self {
        case .getWorkouts: return nil
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .getWorkouts: return ApiManager.shared.defaultHTTPHeaders
        }
    }
}
