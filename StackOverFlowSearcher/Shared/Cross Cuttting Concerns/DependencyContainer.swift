//
//  DependencyContainer.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/13.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import UIKit
import Swinject

let container = Container()

func register<Abstraction>(_ concrete: @escaping () -> Abstraction, for abstractType: Abstraction.Type) {
    container.register(abstractType, factory: { _ in
        concrete()
    })
}

func registerSingleton<Abstraction>(_ concrete: @escaping () -> Abstraction, for abstractType: Abstraction.Type) {
    container.register(abstractType, factory: { _ in
        concrete()
    }).inObjectScope(.container)
}

func resolve<Abstraction>(_ abstractType: Abstraction.Type) -> Abstraction? {
    guard let concreteInstance = container.resolve(abstractType) else {
        log("Failed to find registered implemenatation for \(abstractType)")
        preconditionFailure("You forgot to register an implemenation for \(abstractType)") // Crash in debug, return nil in prod
        return nil
    }
    return concreteInstance
}


fileprivate final class DependencyContainer: StartupModule {
    let excecutionOrder: UInt = .min
    
    func initialise() {
        registerClasses()
        registerImpentationForProtocols()
    }
    
    private func registerImpentationForProtocols() {
        register({ SynchronousHTTPGetClient() }, for: HTTPGetClient.self)
        register({ ArticleRepositoryImplementation() }, for: ArticleRepository.self)
    }
    
    private func registerClasses() {
       
    }
}
