@testable import StackOverFlowSearcher
import XCTest

class HTTPConstantsTests: XCTestCase {
    
    func testPathParametersConstantValues() {
        XCTAssertEqual(HTTPConstants.PathParameterKeys.questionIDPathParemter, "questionID")
    }
    
    func testQueryParameterConstantValues() {
        XCTAssertEqual("order", HTTPConstants.QueryParameterKeys.order)
        XCTAssertEqual("site", HTTPConstants.QueryParameterKeys.site)
        XCTAssertEqual("title", HTTPConstants.QueryParameterKeys.title)
        XCTAssertEqual("filter", HTTPConstants.QueryParameterKeys.filter)
        XCTAssertEqual("sort", HTTPConstants.QueryParameterKeys.sort)
        XCTAssertEqual("pagesize", HTTPConstants.QueryParameterKeys.pageSize)
    }
}
