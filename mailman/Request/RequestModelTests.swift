@testable import mailman

import XCTest

class RequestModelTests: XCTestCase {

    func testUrlRequestSetsCorrectUrl() {
        let testObject = RequestModel()
        testObject.url = "test.url"
        
        XCTAssertEqual(testObject.urlRequest()?.url, URL(string: "test.url"))
    }
    
    func testIfUrlIsEmptyThenUrlRequestReturnsNil() {
        let testObject = RequestModel()
        
        XCTAssertNil(testObject.urlRequest())
    }
    
    func testUrlRequestSetsCorrectMethod() {
        let testObject = RequestModel()
        testObject.url = "test.url"
        testObject.method = .post
        
        XCTAssertEqual(testObject.urlRequest()?.httpMethod, "POST")
    }
    
    func testIfMethodIsEmptyThenUrlRequestReturnsGet() {
        let testObject = RequestModel()
        testObject.url = "test.url"
        
        XCTAssertEqual(testObject.urlRequest()?.httpMethod, "GET")
    }
    
    func testUrlRequestSetsCorrectBody() {
        let testObject = RequestModel()
        testObject.url = "test.url"
        testObject.body = "Test Body"
        
        XCTAssertEqual(testObject.urlRequest()?.httpBody, "Test Body".data(using: .utf8))
    }
    
    func testIfBodyIsEmptyThenUrlRequestReturnsNilBody() {
        let testObject = RequestModel()
        testObject.url = "test.url"
        
        XCTAssertNil(testObject.urlRequest()?.httpBody)
    }
    
    func testUrlRequestSetsCorrectHeaders() {
        let testObject = RequestModel()
        testObject.url = "test.url"
        testObject.headers = [Header(key: "key1", value: "value1"), Header(key: "key2", value: "value2")]
        
        XCTAssertEqual(testObject.urlRequest()?.allHTTPHeaderFields, ["key1":"value1", "key2":"value2"])
    }
    
    func testIfNoHeadersThenUrlRequestReturnsEmptyDictionary() {
        let testObject = RequestModel()
        testObject.url = "test.url"
        
        XCTAssertEqual(testObject.urlRequest()?.allHTTPHeaderFields, [:])
    }
    
    func testIfHeaderHasNoKeyHeaderIsNotAddedToDictionary() {
        let testObject = RequestModel()
        testObject.url = "test.url"
        testObject.headers = [Header(key: "key1", value: "value1"), Header.empty, Header(key: "key3", value: "value3")]

        XCTAssertEqual(testObject.urlRequest()?.allHTTPHeaderFields, ["key1":"value1", "key3":"value3"])
    }
    
    func testIfHeaderHasKeyButNoValueHeaderIsAddedToDictionary() {
        let testObject = RequestModel()
        testObject.url = "test.url"
        testObject.headers = [Header(key: "key1", value: "value1"), Header(key: "key2", value: nil), Header(key: "key3", value: "value3")]
        
        XCTAssertEqual(testObject.urlRequest()?.allHTTPHeaderFields, ["key1":"value1", "key2":"", "key3":"value3"])
    }
    
    func testIsValidReturnsTrueIfUrlIsNotEmpty() {
        let testObject = RequestModel()
        testObject.url = "test.url"
        
        XCTAssertTrue(testObject.isValid())
    }
    
    func testIsValidReturnsFalseIfUrlIsEmpty() {
        let testObject = RequestModel()
        testObject.url = ""
        
        XCTAssertFalse(testObject.isValid())
    }

}
