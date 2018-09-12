@testable import mailman
import XCTest

class NetworkRequestModelTests: XCTestCase {
    let session = MockURLSession()

    func testIsValidReturnsFalseWhenUrlIsEmpty() {
        XCTAssertFalse(NetworkRequestService.isValid(requestData: RequestData(url: nil, method: .get, body: "")))
        XCTAssertFalse(NetworkRequestService.isValid(requestData: RequestData(url: "", method: .get, body: "")))
    }
    
    func testIsValidReturnsFalseWhenMethodIsNil() {
        XCTAssertFalse(NetworkRequestService.isValid(requestData: RequestData(url: "http://test.url", method: nil, body: "")))
    }
    
    func testIsValidReturnsTrueWhenRequestDataIsValid() {
        XCTAssertTrue(NetworkRequestService.isValid(requestData: RequestData(url: "http://test.url", method: .get, body: "")))
    }
    
    func testWhenSendRequestReceivesValidRequestDataTheCorrectURLIsUsed() {
        let subject = NetworkRequestService(session: session)
        let requestData = RequestData(url: "https://postman-echo.com/get?test=MyMessage", method: .get, body: "")
        
        subject.sendRequest(requestData: requestData)
        
        XCTAssertEqual(session.lastURL?.url?.absoluteString, requestData.url)
    }
    
    func testWhenSendRequestCalledRequestIsStarted() {
        let subject = NetworkRequestService(session: session)
        let dataTask = MockURLSessionDataTask()
        let requestData = RequestData(url: "https://postman-echo.com/get?test=MyMessage", method: .get, body: "")

        session.nextDataTask = dataTask
        
        subject.sendRequest(requestData: requestData)
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
//    func testWhenSendRequestCalledWithValidRequestDataDataIsReturned() {
//        let subject = NetworkRequestService(session: session)
//        let data = "Test Data".data(using: .utf8)
//        let urlResponse = 
//        let error =
//        
//        subject.completion(data: data, urlResponse: urlResponse, error: error)
//        
//        
//        
//        
//    }
    
}
