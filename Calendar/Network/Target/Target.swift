//
//  Target.swift
//  HaaS
//
//  Created by Techchain on 19/05/2021
//  Copyright © 2020 Techchain. All rights reserved.
//

import Foundation
import Alamofire

protocol Target {
    var path: String { get }
    var method: HTTPMethod { get }
    var params: Parameters? { get }
    var headers: HTTPHeaders { get }
}
