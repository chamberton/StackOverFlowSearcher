//
//  Logger.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/13.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//


import SwiftyBeaver

func log(_ object: Any) {
    LoggerInstance.shared.log.verbose(object)
}

fileprivate class LoggerInstance {
    fileprivate let log = SwiftyBeaver.self
    fileprivate static let shared = LoggerInstance()
    
    private let console = ConsoleDestination()

    private init() {
        console.format = "$DHH:mm:ss$d $L $M"
        log.addDestination(console)
        let file = FileDestination.init()
        log.addDestination(file)
    }
}
