//
//  HTTPClient.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/12.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import UIKit

protocol HTTPGetClient {
    func get(from host: Host,
             urlBuildable: URLBuildable,
             queryParameters: HTTPDictionary,
             pathParameters: [String],
             additionalHeaders: HTTPDictionary,
             timeoutInterval: TimeInterval) -> Result<Data, HTTPError>
}


class SynchronousHTTPGetClient: HTTPGetClient {
    private lazy var connectivityInteractor = resolve(ConnectivityInteractor.self)
    private lazy var synchronousDispatchGroup = DispatchGroup()
    
    func get(from host: Host,
             urlBuildable: URLBuildable,
             queryParameters: HTTPDictionary,
             pathParameters: [String],
             additionalHeaders: HTTPDictionary,
             timeoutInterval: TimeInterval) -> Result<Data, HTTPError> {
        
        guard connectivityInteractor?.isConnectedToInternet == true else {
            return .failure(.noInternetConnection)
        }
        guard let url = urlBuildable.url(inHost: host, queryParameters: queryParameters, pathParameters: pathParameters) else {
            return .failure(.invalidParameters)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = additionalHeaders.mapValues{ $0.description }
        urlRequest.httpMethod = "GET"
        urlRequest.timeoutInterval = timeoutInterval
        
        assertNotInMainThread()
        return performHTTPOperation(for: urlRequest)
    }
    
    private func performHTTPOperation(for urlRequest: URLRequest) -> Result<Data,HTTPError> {
        var httpResponseData: Data?
        var httpOperationError: HTTPError?
        
        synchronousDispatchGroup.enter()
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error)  in
            guard let httpResponse = response as? HTTPURLResponse else {
                httpOperationError = .failed
                self.synchronousDispatchGroup.leave()
                return
            }
            let statusCode = httpResponse.statusCode
            
            if 404 == statusCode {
                httpOperationError = .notFound
            } else if let data = data, 200...299 ~= statusCode {
                httpResponseData = data
            } else {
                httpOperationError = .failed
            }
            self.synchronousDispatchGroup.leave()
            self.logOperattionResult(for: urlRequest, data: data)
        })
        
        task.resume()
        synchronousDispatchGroup.wait()
        
        
        if let responseData = httpResponseData {
            return .success(responseData)
        } else  if let error = httpOperationError {
            return .failure(error)
        } else {
            return .failure(HTTPError.failed)
        }
    }
    
    private func assertNotInMainThread() {
        precondition(!Thread.isMainThread,"Service Calls must be made in the background thread")
    }
    
    private func logOperattionResult(for urlRequest: URLRequest, data: Data?) {
        if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            log("""
                \n Operation at \(String(describing: urlRequest.url!.absoluteString))
                Headers: \n \(String(describing: urlRequest.allHTTPHeaderFields))
                Body: \n \(String(describing: urlRequest.httpBody))
                Response: \n \(json))
                """)
        } else {
            log("""
                \n Operation at \(String(describing: urlRequest.url!.absoluteString))
                Headers: \n \(String(describing: urlRequest.allHTTPHeaderFields))
                Body: \n \(String(describing: urlRequest.httpBody))
                """)
        }
    }
}
