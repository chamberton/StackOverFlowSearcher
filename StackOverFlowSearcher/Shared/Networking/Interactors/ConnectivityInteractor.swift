//
//  ConnectivityInteractor.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/12.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import Foundation
import Reachability

final class ConnectivityInteractor: StartupModule, DependencyResolvable {
    var resolutionType = ConnectivityInteractor.self
    let excecutionOrder: UInt = 0
    private let reachability: Reachability
    private(set) var isReachable: Bool = false
    
    /// Returns the current state of the devvice connectivity to the internet
    ///
    /// `true`, is returned if the device is connected to internet thru Wifi of Mobile data,  result is`false` otherwise
    var isConnectedToInternet: Bool { isReachable }

    init() {
        do {
            try reachability = Reachability(hostname: "www.google.co.za")
        } catch {
            fatalError("Failed to initialised start up module")
        }
    }
    
    func registerInDependecyContainer() {
        registerSingleton({ self }, for: ConnectivityInteractor.self)
    }
    
    func execute() {
        startTrackingNetworkStatus()
    }
    
    /// Start detecting whether or not the device is connected to the Internet
    func startTrackingNetworkStatus() {
        isReachable =  reachability.connection != .unavailable
        do {
            try reachability.startNotifier()
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(reachabilityChanged),
                                                   name: Notification.Name.reachabilityChanged,
                                                   object: reachability)
        } catch {
            log("could not start reachability notifier")
        }
    }
    
    @objc private func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        isReachable = reachability.connection != .unavailable
    }
    
    deinit { NotificationCenter.default.removeObserver(self) }
}
