//
//  ApiPath.swift
//  CarusStaff
//
//  Created by Techchain on 2/25/20.
//  Copyright © 2020 Techchain. All rights reserved.
//

import Foundation
import Foundation

func / (lhs: String, rhs: String) -> String {
    return lhs + "/" + rhs
}

struct ApiPath {
    static var apiDomain = ConfigKey.apiDomain.configFromInfoPlist()
}
