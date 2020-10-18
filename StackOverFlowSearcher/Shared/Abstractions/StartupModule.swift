//
//  StartupModule.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/14.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import UIKit

// Protocol that indicates that the conforming type is a start module and should be run on start up
@objc protocol StartupModule: class {
    
    var excecutionOrder: UInt { get }
    
    init()
    func execute()
}
