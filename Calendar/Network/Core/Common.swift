//
//  CommonError.swift
//  FestFive
//
//  Created by Techchain on 26/02/2021.
//

import Foundation

struct CommonError: Error {
    var localizedDescription: String
    let code: Int
    
    init(message: String? = nil, code: Int = 0) {
        self.code = code
        self.localizedDescription = message ?? ""
    }
    
    init(error: Error) {
        self.localizedDescription = error.localizedDescription
        self.code = 0
    }
    
    static let noResponse = CommonError(message: "Server returns no information and closes the connection.", code: 444)
    static let noInternetConnection = CommonError(message: "The Internet connection appears to be offline", code: -1_005)
    static let unauthorized = CommonError(message: "Session Expired", code: 401)
    static let unknownError = CommonError(message: "Common.unexpectedError".localized(), code: -1)
}

