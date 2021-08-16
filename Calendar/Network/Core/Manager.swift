//
//  Manager.swift
//  CarusStaff
//
//  Created by Techchain on 2/25/20.
//  Copyright © 2020 Techchain. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

typealias ApiCompletion<T> = (Swift.Result<T, CommonError>) -> Void
typealias Listenser<T> = (T) -> Void

class ApiManager {
    static var shared = ApiManager()
    private init() { }
    
    var configuration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        return configuration
    }
    
    var session: Session = {
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
          let userInfo = ["date": Date()]
          return CachedURLResponse(
            response: response.response,
            data: response.data,
            userInfo: userInfo,
            storagePolicy: .allowed)
        })
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return Session(configuration: configuration, cachedResponseHandler: responseCacher)
    }()
    
    var youtubeSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        configuration.httpShouldSetCookies = false
        return Session(configuration: configuration)
    }()
    
    var defaultHTTPHeaders: HTTPHeaders {
        var headers = [HTTPHeader]()
        let language = "en"
        let languageHeader = HTTPHeader(name: "X-localization", value: language)
        headers.append(languageHeader)
//        if !AccountManager.shared.accessToken.isEmpty {
//            let authoHeader = HTTPHeader(name: "Authorization", value: "Bearer " + AccountManager.shared.accessToken)
//            headers.append(authoHeader)
//        }
        return HTTPHeaders(headers)
    }
    
    var youtubeHTTPHeaders: HTTPHeaders {
        var headers = [HTTPHeader]()
        headers.append(HTTPHeader(name: "Accept-Language", value: "en"))
        headers.append(HTTPHeader(name: "Referer", value: "https://youtube.com/watch?v=Tzfp-MaU63M"))
        headers.append(HTTPHeader(name: "User-Agent", value: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Safari/605.1.15"))
        headers.append(HTTPHeader(name: "Accept", value: "*/*"))
        return HTTPHeaders(headers)
    }

    var networkAvailable: Bool {
        return true
    }

    var uploadRequest: Request?
}
