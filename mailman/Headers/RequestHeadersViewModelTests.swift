@testable import mailman
import XCTest

class RequestHeadersViewModelTests: XCTestCase {

    func testHeadersArrayReturnsArrayOfHeadersWithEmptyValues() {
        let expectedHeader = Header(key: "key3", value: "value3")
        let expectedHeadersArray = [Header.empty, Header.empty, expectedHeader]
        let testObject = RequestHeadersViewModel(headers: [2: expectedHeader])
        
        let actualHeadersArray = testObject.headers
        
        XCTAssertEqual(actualHeadersArray, expectedHeadersArray)
    }
    
    func testHeadersArrayReturnsEmptyArrayWhenNoHeaders() {
        let testObject = RequestHeadersViewModel(headers: [:])
        
        XCTAssertEqual(testObject.headers, [Header.empty])
    }
    

}
