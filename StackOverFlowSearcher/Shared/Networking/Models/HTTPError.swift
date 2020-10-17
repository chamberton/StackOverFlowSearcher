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
        default:
            return ""
        }
    }
    
    var messageForRenderedError: String {
           switch self {
           case .noInternetConnection:
               return "Please make sure that your device is connected to the Internet"
            case .unknown:
                       return "Something wrong occured"
           default:
               return ""
           }
       }
}
