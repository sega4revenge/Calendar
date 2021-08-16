//
//  Request.swift
//  CarusStaff
//
//  Created by Techchain on 2/25/20.
//  Copyright © 2020 Techchain. All rights reserved.
//

import Foundation
import Alamofire

extension ApiManager {
    // MARK: - API Request
    /// Send a request to server
    ///
    /// - parameter target:  Target info of request Include: url, method, headers, params.
    //
    
    func request<T: Decodable>(target: Target, completion: @escaping ApiCompletion<T>) {
        let encoding: ParameterEncoding
        if target.method == .post || target.method == .patch || target.method == .put {
            encoding = JSONEncoding.default
        } else {
            encoding = URLEncoding.default
        }
        if let request = try? URLRequest(url: target.path, method: target.method, headers: target.headers), let cacheResponse = session.sessionConfiguration.urlCache?.cachedResponse(for: request) {
            handleData(data: cacheResponse.data, completion: completion)
        }
        
        
        session.request(target.path, method: target.method, parameters: target.params, encoding: encoding, headers: target.headers)
            .validate()
            .responseData { [weak self] (response) in
                switch response.result {
                case .failure(let e):
                    var requestError: RequestError
                    var error: CommonError
                    if let data = response.data {
                        do {
                            let decoded = try JSONDecoder().decode(FailedResponse.self, from: data)
                            error = CommonError(message: decoded.message, code: decoded.code ?? -1)
                            if error.code == 10002 {
                                requestError = .block
                            } else if e.responseCode == 401 {
                                requestError = .sessionExpired
                            } else {
                                requestError = .unknown
                            }
                        } catch let e {
                            dump("Error: \(e.localizedDescription) at line \(#line) in \(#file)")
                            error = CommonError.init(error: e)
                            requestError = .unknown
                        }
                    } else {
                        switch e {
                        case .sessionTaskFailed(let internalError):
                            error = CommonError.init(error: internalError)
                        default:
                            error = CommonError.init(error: e)
                        }
                        requestError = .unknown
                    }
                    switch requestError {
                    case .block:
                        break
                    case .sessionExpired:
                        break
                    case .unknown:
                        completion(.failure(error))
                    }
                case .success(let data):
                    self?.handleData(data: data, completion: completion)
                }
            }
    }
    
    
    func requestData(target: Target, completion: @escaping ApiCompletion<Data>) {
        let encoding: ParameterEncoding
        if target.method == .post || target.method == .patch || target.method == .put {
            encoding = JSONEncoding.default
        } else {
            encoding = URLEncoding.default
        }
        youtubeSession.request(target.path, method: target.method, parameters: target.params, encoding: encoding, headers: target.headers)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .failure(let e):
                    let error = CommonError(error: e)
                    completion(.failure(error))
                case .success(let data):
                    completion(.success(data))
                }
            }
    }
    
    // MARK: - Upload
    // TODO: - Update RxSwift
    func upload<T: Decodable>(target: Target, datas: [UploadData], completion: @escaping ApiCompletion<T>, progress: @escaping (Double) -> Void) -> UploadRequest {
        let request = session.upload(multipartFormData: { (multipartFormData) in
            for data in datas {
                multipartFormData.append(data.data, withName: data.name, fileName: "image.png", mimeType: "image/png")
            }
        }, to: target.path, headers: target.headers)
        .uploadProgress(queue: .main, closure: { info in
            progress(info.fractionCompleted)
        })
        .responseData(completionHandler: { data in
            switch data.result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(Response<T>.self, from: data)
                    if let result = decoded.data {
                        completion(.success(result))
                    } else {
                        let error = CommonError(message: decoded.message, code: decoded.code ?? -1)
                        completion(.failure(error))
                    }
                } catch let e {
                    let error = CommonError(error: e)
                    completion(.failure(error))
                }
            case .failure(let e):
                let error = CommonError(error: e)
                completion(.failure(error))
            }
        })
        return request
    }
    
    func handleData<T: Decodable>(data: Data, completion: @escaping ApiCompletion<T>) {
        do {
            let decoded = try JSONDecoder().decode(Response<T>.self, from: data)
            if T.self == Dataless.self {
                let nullable = Dataless(message: decoded.message, code: decoded.code) as! T
                completion(.success(nullable))
                return
            } else if let result = decoded.data {
                completion(.success(result))
            } else {
                let error = CommonError(message: decoded.message, code: decoded.code ?? -1)
                completion(.failure(error))
            }
        } catch let e {
            dump("Error: \(e.localizedDescription) at line \(#line) in \(#file)")
            completion(.failure(CommonError.unknownError))
        }
    }
    
    // MARK: - Cancel upload
    /// Cancel current uploading
    func cancelUpload() {
        uploadRequest?.cancel()
        uploadRequest = nil
    }
}

extension ApiManager {
    enum RequestError {
        case block
        case sessionExpired
        case unknown
    }
}
