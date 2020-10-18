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
            return "No connectivity"
        case .unknown:
            return "Error"
        case .timedOut:
            return "Time out"
        case .failed:
            return "Failure"
        case .invalidParameters:
             return "Invalid request"
        case .notFound:
             return "Unreachable"
        case .badData:
             return "Bad data"
        }
    }
    
    var messageForRenderedError: String {
        switch self {
        case .noInternetConnection:
            return "Please make sure that your device is connected to the Internet."
        case .unknown:
            return "Something wrong occured."
        case .timedOut:
            return "Operation timed out."
        case .failed:
            return "Unable to load"
        case .invalidParameters:
            return "Invalid psremeters were foundf inyour request."
        case .notFound:
            return "No content were found at requested URL"
        case .badData:
            return "We received data that could not haved been iterpreted."
        }
    }
}
