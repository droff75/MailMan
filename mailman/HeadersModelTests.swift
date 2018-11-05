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
    
    func testHeadersArrayReturnsArrayOfHeadersWithEmptyValues() {
        let expectedHeader = Header(key: "key3", value: "value3")
        let expectedHeadersArray = [Header.empty, Header.empty, expectedHeader]
        let testObject = HeadersModel(headers: [2: expectedHeader])

        let actualHeadersArray = testObject.headersArray

        XCTAssertEqual(actualHeadersArray, expectedHeadersArray)
    }
    
    func testHeadersArrayReturnsEmptyArrayWhenNoHeaders() {
        let testObject = HeadersModel(headers: [:])
        
        XCTAssertEqual(testObject.headersArray, [])
    }
}


