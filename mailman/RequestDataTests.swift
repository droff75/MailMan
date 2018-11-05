@testable import mailman
import XCTest

class RequestDataTests: XCTestCase {

    func testUrlRequestSetsCorrectUrl() {
        let testObject = RequestData(url: "test.url", method: nil, body: nil, headers: nil)
        
        XCTAssertEqual(testObject.urlRequest()?.url, URL(string: "test.url"))
    }
    
    func testIfUrlIsEmptyThenUrlRequestReturnsNil() {
        let testObject = RequestData(url: nil, method: nil, body: nil, headers: nil)
        
        XCTAssertNil(testObject.urlRequest())
    }
    
    func testUrlRequestSetsCorrectMethod() {
        let testObject = RequestData(url: "test.url", method: .post, body: nil, headers: nil)
        
        XCTAssertEqual(testObject.urlRequest()?.httpMethod, "POST")
    }
    
    func testIfMethodIsEmptyThenUrlRequestReturnsGet() {
        let testObject = RequestData(url: "test.url", method: nil, body: nil, headers: nil)

        XCTAssertEqual(testObject.urlRequest()?.httpMethod, "GET")
    }
    
    func testUrlRequestSetsCorrectBody() {
        let testObject = RequestData(url: "test.url", method: nil, body: "Test Body", headers: nil)
        
        XCTAssertEqual(testObject.urlRequest()?.httpBody, "Test Body".data(using: .utf8))
    }
    
    func testIfBodyIsEmptyThenUrlRequestReturnsNilBody() {
        let testObject = RequestData(url: "test.url", method: nil, body: nil, headers: nil)
        
        XCTAssertNil(testObject.urlRequest()?.httpBody)
    }
    
    func testUrlRequestSetsCorrectHeaders() {
        let testObject = RequestData(url: "test.url", method: nil, body: nil, headers: [Header(key: "key1", value: "value1"), Header(key: "key2", value: "value2")])
        
        XCTAssertEqual(testObject.urlRequest()?.allHTTPHeaderFields, ["key1":"value1", "key2":"value2"])
    }
}
