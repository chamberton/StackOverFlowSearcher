//
//  URLBuildableTests.swift
//  StackOverFlowSearcherTests
//
//  Created by Serge Mbamba on 2020/10/14.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//


@testable import StackOverFlowSearcher
import XCTest

class URLBuildableTests: XCTestCase {
    
    func testThatAllParameterAreSetCorrectly() {
        let parameters = ["parameterKey":"paremterValue"]
        let pathParameters = ["path1","1"]
        
        let url = StakOverflowHTTPPath.searchItem.url(inHost: .stackOverFlow, queryParameters: parameters, pathParameters: pathParameters)
        
        XCTAssertNotNil(url)
        XCTAssertEqual("https://api.stackexchange.com/2.2/search/advanced/path1/1?parameterKey=paremterValue", url?.absoluteString)
    }
}
