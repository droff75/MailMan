@testable import mailman
import XCTest

class HeadersModelTests: XCTestCase {

    func testInitCreatesEmtpyHeadersDictionary() {
        let testObject = HeadersModel()
        let expectedHeaders: [Int: Header] = [:]
        
        XCTAssertEqual(testObject.headers, expectedHeaders)
    }
    
    func testHeaderIsInitializedWithHeadersThatWerePassedIn() {
        let expectedHeaders: [Int:Header] = [0 : Header(key: "key1", value: "value1"),
                                             1 : Header(key: "key2", value: "value2")]

        let testObject = HeadersModel(headers: expectedHeaders)

        XCTAssertEqual(testObject.headers, expectedHeaders)
    }
    
    func testUpdateAddsHeaderToHeaders() {
        let testObject = HeadersModel()
        let expectedHeader = Header(key: "blarg", value: "oog")
        
        testObject.update(header: expectedHeader, at: 4)
        
        XCTAssertEqual(testObject.headers, [4: expectedHeader])
    }
    
    func testEmptyHeadersNotAddedToHeadersDictionary() {
        let expectedHeaders: [Int:Header] = [0 : Header(key: "key1", value: "value1")]
        let testObject = HeadersModel(headers: expectedHeaders)
        testObject.update(header: Header(key: "", value: ""), at: 1)
        
        XCTAssertEqual(testObject.headers, expectedHeaders)
    }
    
    func testEmptyHeadersRemovedFromHeadersDictionary() {
        let expectedHeaders: [Int:Header] = [0 : Header(key: "key1", value: "value1")]
        let testObject = HeadersModel(headers: expectedHeaders)
        testObject.update(header: Header(key: "", value: ""), at: 0)
        
        XCTAssertEqual(testObject.headers, [Int:Header]())
    }
}


