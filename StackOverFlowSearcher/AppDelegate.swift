//
//  AppDelegate.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/12.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var startUpModules: [StartupModule] = {
        var startUpModules = [StartupModule]()
        let allClassesInModule = objc_getClassList()
        
        for aClass in allClassesInModule {
            if class_conformsToProtocol(aClass, StartupModule.self) {
                guard let ClassType = aClass as? StartupModule.Type else {
                    continue
                }
                let instance = ClassType.init()
                if let dependencyResolvable = instance as? DependencyResolvable {
                    dependencyResolvable.registerInDependecyContainer()
                }
                startUpModules.append(instance)
            }
        }
        return startUpModules.sorted { (lhs, rhs) -> Bool in
            return lhs.excecutionOrder < rhs.excecutionOrder
        }
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        for startUpModule in startUpModules {
            startUpModule.execute()
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}
