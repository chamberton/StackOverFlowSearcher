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
    var implementatationUnderTest: QuestionsSearchController!
    var mockedArticleRepository: MockArticleRepository!
    
    override func setUp() {
        mockedArticleRepository = MockArticleRepository()
        register({ self.mockedArticleRepository }, for: ArticleRepository.self)
        implementatationUnderTest = QuestionsSearchController(maximumResultCount: 20)
    }
    
    override func tearDown() {
        implementatationUnderTest = nil
        super.tearDown()
    }
    
    func testCorrectValuesOfPropertiesAtInitialisation() {
        XCTAssertNotNil(implementatationUnderTest)
        XCTAssertEqual(20, implementatationUnderTest.maximumResultCount)
    }
    
    func testThatWhenArticlesAreFetchedThenSuccessBlockIsExecuted() {
        stub(mockedArticleRepository) { mock in
            when(mock).fecthArticles(searchTerm: any(), pageSize: any()).thenReturn([])
        }
        let successExpectation = expectation(description: "Wait for success block")
        implementatationUnderTest.searchArticles(containing: "map", articlesHandler: { _ -> (Void) in
            successExpectation.fulfill()
        }) { _ -> (Void) in
            XCTFail("Should not receive an error")
        }
        wait(for: [successExpectation], timeout: 5)
    }
    
    func testThatWhenArticlesFetchedFailedThenErrorBlockIsExecuted() {
        stub(mockedArticleRepository) { mock in
            when(mock).fecthArticles(searchTerm: any(), pageSize: any()).thenThrow(HTTPError.failed)
        }
        
        let failureExpectation = expectation(description: "Wait for failure block")
        implementatationUnderTest.searchArticles(containing: "map", articlesHandler: { _ -> (Void) in
            XCTFail("Should not be a success")
        }) { _ -> (Void) in
            
            failureExpectation.fulfill()
        }
        wait(for: [failureExpectation], timeout: 5)
    }
    
    func testThatWhenArticlesFetchedFailedWithUnknownErrorThenErrorBlockIsExecuted() {
        stub(mockedArticleRepository) { mock in
            when(mock).fecthArticles(searchTerm: any(), pageSize: any()).thenThrow(NSError(domain: "A domain", code: -1, userInfo: nil))
        }
        
        let failureExpectation = expectation(description: "Wait for failure block")
        implementatationUnderTest.searchArticles(containing: "map", articlesHandler: { _ -> (Void) in
            XCTFail("Should not be a success")
        }) { _ -> (Void) in
            
            failureExpectation.fulfill()
        }
        wait(for: [failureExpectation], timeout: 5)
    }
}
