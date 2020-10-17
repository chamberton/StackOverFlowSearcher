//
//  HTTPPath.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/12.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import Foundation

enum StakOverflowHTTPPath: String, URLBuildable {
    var basePath: String { rawValue }
    
    case searchItem = "search/advanced"
    case itemDetails = "questions"
}
