@testable import mailman
import XCTest

class NetworkRequestModelTests: XCTestCase {

    func testIsValidReturnsFalseWhenUrlIsEmpty() {
        XCTAssertFalse(NetworkRequestModel.isValid(requestData: RequestData(url: nil, method: .get)))
        XCTAssertFalse(NetworkRequestModel.isValid(requestData: RequestData(url: "", method: .get)))
    }
    
    func testIsValidReturnsFalseWhenMethodIsNil() {
        XCTAssertFalse(NetworkRequestModel.isValid(requestData: RequestData(url: "http://test.url", method: nil)))
    }
    
    func testIsValidReturnsTrueWhenRequestDataIsValid() {
        XCTAssertTrue(NetworkRequestModel.isValid(requestData: RequestData(url: "http://test.url", method: .get)))
    }
    
    func testWhenNetworkRequestMadeWithValidRequestDataThatValidResponseReceived() {
        let requestData = RequestData(url: "https://postman-echo.com/get?test=MyMessage", method: .get)
        
        NetworkRequestModel().sendRequest(requestData: requestData)
        
    }
    
}
