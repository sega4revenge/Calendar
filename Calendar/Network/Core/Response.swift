//
//  ResponseObject.swift
//  
//
//  Created by Techchain on 2/25/20.
//  Copyright © 2020 Techchain. All rights reserved.
//

import Foundation

class Response<T: Decodable>: Decodable {
    var code: Int?
    var message: String?
    var data: T?
}

struct FailedResponse: Decodable {
    var code: Int?
    var message: String?
}

struct Dataless: Decodable {
    var message: String?
    var code: Int?
}

struct PagingResponse<T: Decodable>: Decodable {
    var limit: Int?
    var results: [T]?
    var total: Int?
    var page: Int?
}
