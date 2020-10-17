//
//  Host.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/12.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import Foundation

enum Host: String {
    case stackOverFlow = "https://api.stackexchange.com"
    
    var activeApiVersion: String {
        switch self {
        case .stackOverFlow:
            return "2.2"
        }
       
    }
}
