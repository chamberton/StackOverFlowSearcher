//
//  ArticlesControllerTests.swift
//  StackOverFlowSearcherTests
//
//  Created by Serge Mbamba on 2020/10/15.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

@testable import StackOverFlowSearcher
@testable import Cuckoo
import XCTest

class ArticlesSearchControllerTests: XCTestCase {
    var implementatationUnderTest: ArticlesSearchController!
    var mockedArticleRepository: MockArticleRepository!
    
    override func setUp() {
        mockedArticleRepository = MockArticleRepository()
        implementatationUnderTest = ArticlesSearchController(maximumResultCount: 20)
    }
    
    override func tearDown() {
        implementatationUnderTest = nil
        super.tearDown()
    }

    

}
