@testable import mailman
import XCTest

class NetworkRequestModelTests: XCTestCase {
    let session = MockURLSession()

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
    
    func testWhenSendRequestReceivesValidRequestDataTheCorrectURLIsUsed() {
        let subject = NetworkRequestModel(session: session)
        let requestData = RequestData(url: "https://postman-echo.com/get?test=MyMessage", method: .get)
        
        subject.sendRequest(requestData: requestData)
        
        XCTAssertEqual(session.lastURL?.url?.absoluteString, requestData.url)
    }
    
    func testWhenSendRequestCalledRequestIsStarted() {
        let subject = NetworkRequestModel(session: session)
        let dataTask = MockURLSessionDataTask()
        let requestData = RequestData(url: "https://postman-echo.com/get?test=MyMessage", method: .get)

        session.nextDataTask = dataTask
        
        subject.sendRequest(requestData: requestData)
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
//    func testWhenSendRequestCalledWithValidRequestDataDataIsReturned() {
//        let subject = NetworkRequestModel(session: session)
//        let requestData = RequestData(url: "https://postman-echo.com/get?test=MyMessage", method: .get)
//        var data: Data?
//        
//        subject.sendRequest(requestData: requestData)
//        
//        XCTAssertNotNil()
//    }
    
}
