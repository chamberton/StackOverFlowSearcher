//
//  HTTPConstants.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/12.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import Foundation

struct HTTPConstants {
    @available(*, unavailable) private init() {}
    
    struct QueryParameterKeys {
        @available(*, unavailable) private init() {}
        static let order = "order"
        static let site = "site"
        static let filter = "filter"
        static let sort = "sort"
        static let pageSize = "pagesize"
        static let title = "title"
    }
    
    struct PathParameterKeys {
        @available(*, unavailable) private init() {}
        static let questionIDPathParemter = "questionID"
    }
    
}
