//
//  BaseServerOperation.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import Alamofire
import Foundation

class BaseServerOperation<T> {
    
    let baseUrl: String
    open var method: HTTPMethod
    
    fileprivate var sessionManager: SessionManager!
    
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
        method = .get
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 30
        
        sessionManager = SessionManager(configuration: configuration)
    }
    
    // MARK: - Runtime
    
    func run(_ completion: @escaping ((T) -> Void), failure: @escaping ((Error) -> Void)) {
        let backgroundQueue = DispatchQueue.global(qos: .background)
        let urlString: String
        if let urlSufix = serverOperationUrlSuffix() {
            urlString = "\(baseUrl)\(urlSufix)"
        } else {
            urlString = baseUrl
        }
        
        let request = sessionManager.request(urlString, method: method, parameters: serverOperationParameters(), encoding: parameterEncodingForHTTPMethod(method), headers: serverOperationHeaders())
        request.validate(statusCode: 200..<300)
        request.validate(contentType: ["application/json"])
        
        request.responseJSON(queue: backgroundQueue, options: []) { response in
            backgroundQueue.async {
                switch response.result {
                case .failure(_):
                    if let data = response.data, let jsonData = try? JSONSerialization.jsonObject(with: data, options: []), let customError = self.errorWithData(jsonData) {
                        DispatchQueue.main.async {
                            failure(customError)
                        }
                    } else {
                        DispatchQueue.main.async {
                            failure(Error.unknownError)
                        }
                    }
                    break
                case .success(let result):
                    if let result = self.resultForData(result) {
                        DispatchQueue.main.async {
                            completion(result)
                        }
                    } else {
                        DispatchQueue.main.async {
                            failure(Error.unknownError)
                        }
                    }
                    break
                }
            }
        }
    }
    
    func parameterEncodingForHTTPMethod(_ method: HTTPMethod) -> Alamofire.ParameterEncoding {
        var encoding: Alamofire.ParameterEncoding
        if self.method == .get {
            encoding = Alamofire.URLEncoding.default
        } else {
            encoding = Alamofire.URLEncoding.httpBody
        }
        return encoding
    }
    
    // MARK: - Response parsing
    
    /** Error for server error response */
    
    func errorWithData(_ data: Any) -> Error? {
        return nil
    }
    
    func resultForData(_ data: Any) -> T? {
        return nil
    }
    
    // MARK: - Operation parameters
    
    /** Server operation url sufix */
    func serverOperationUrlSuffix() -> String? {
        return nil
    }
    
    /** Server operation parameters */
    func serverOperationParameters() -> [String: Any]? {
        return nil
    }
    
    /** Server operation geaders */
    func serverOperationHeaders() -> [String: String]? {
        return nil
    }
}
