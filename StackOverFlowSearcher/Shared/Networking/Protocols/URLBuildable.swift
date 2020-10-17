//
//  URLBuildable.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/12.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import Foundation

protocol URLBuildable {
    var basePath: String { get }
    func url(inHost host: Host,
             queryParameters: HTTPDictionary,
             pathParameters: [String]) -> URL?
}

extension URLBuildable {
    func url(inHost host: Host,
             queryParameters: [String : CustomStringConvertible],
             pathParameters: [String]) -> URL? {
        let allPathParamers = [basePath] + pathParameters
        let separtingCharacter = "/"
        var urlPath = host.rawValue + separtingCharacter + host.activeApiVersion + allPathParamers.reduce(into: separtingCharacter) { accumulatedPathParamters, pathParameter in
            accumulatedPathParamters += (pathParameter + separtingCharacter)
        }
        urlPath.removeLast()
        guard
            let fullURL = URL(string: urlPath),
            var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: true) else {
            return nil
        }
        for (key,value) in queryParameters {
            let escapedValue = value.description.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            if components.queryItems == nil {
                components.queryItems = [URLQueryItem]()
            }
            components.queryItems?.append(URLQueryItem(name: key, value: escapedValue ))
        }
        return components.url
    }
}
