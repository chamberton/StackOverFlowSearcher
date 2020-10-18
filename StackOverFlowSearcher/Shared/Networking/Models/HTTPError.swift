//
//  HTTPError.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/14.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import UIKit

enum HTTPError: Error {
    case noInternetConnection
    case timedOut
    case failed
    case invalidParameters
    case notFound
    case unknown
    case badData
    
    
    var titleForRenderedError: String {
        switch self {
        case .noInternetConnection:
            return LocalizedCopy(named: "000-No-connectivity-title")
        case .unknown:
            return LocalizedCopy(named: "000-Error")
        case .timedOut:
            return LocalizedCopy(named: "000-Timeout-title")
        case .failed:
           return LocalizedCopy(named: "000-Failure")
        case .invalidParameters:
             return LocalizedCopy(named: "000-Invalid-request")
        case .notFound:
            return LocalizedCopy(named: "000-Unreachable")
        case .badData:
             return LocalizedCopy(named: "000-Bad-data-title")
        }
    }
    
    var messageForRenderedError: String {
        switch self {
        case .noInternetConnection:
            return LocalizedCopy(named: "000-No-Internet")
        case .unknown:
            return LocalizedCopy(named: "000-No-Error-message")
        case .timedOut:
            return LocalizedCopy(named: "000-Time-out")
        case .failed:
            return LocalizedCopy(named: "000-Failed")
        case .invalidParameters:
            return LocalizedCopy(named: "000-Invalid-param")
        case .notFound:
            return LocalizedCopy(named: "000-Not-found")
        case .badData:
            return LocalizedCopy(named: "000-Bad-data")
        }
    }
}
