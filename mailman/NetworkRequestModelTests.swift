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
        let requestData = RequestData(url: "http://test.url", method: .get, body: "")
        
        subject.sendRequest(requestData: requestData)
        
        XCTAssertEqual(session.lastURL?.url?.absoluteString, requestData.url)
    }
    
    func testWhenSendRequestCalledRequestIsStarted() {
        let subject = NetworkRequestService(session: session)
        let dataTask = MockURLSessionDataTask()
        let requestData = RequestData(url: "http://test.url", method: .get, body: "")

        session.nextDataTask = dataTask
        
        subject.sendRequest(requestData: requestData)
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testWhenCompletionCalledWithValidDataAndResponseThenCorrectDelegateFunctionIsCalled() {
        let service = NetworkRequestService(session: session)
        let testDelegate = MockMainRequestViewVC()
        service.delegate = testDelegate
        
        let data = "Test Data".data(using: .utf8)
        let urlResponse = URLResponse.init(url: URL(string: "http://test.url")!, mimeType: "testMimeType", expectedContentLength: 1, textEncodingName: "testEncoding")
        let error = Error?.init(nilLiteral: ())
        
        service.completion(data: data, urlResponse: urlResponse, error: error)

        XCTAssertNotNil(MockMainRequestViewVC.data)
        XCTAssertNotNil(MockMainRequestViewVC.urlResponse)
        XCTAssertNil(MockMainRequestViewVC.error)
    }
    
    func testWhenCompletionCalledWithErrorThenCorrectDelegateFunctionIsCalled() {
        let service = NetworkRequestService(session: session)
        let testDelegate = MockMainRequestViewVC()
        service.delegate = testDelegate
        
        let data = Data?.init(nilLiteral: ())
        let urlResponse = URLResponse?.init(nilLiteral: ())
        let error = NSError.init(domain: "testDomain", code: 999, userInfo: nil)
        
        service.completion(data: data, urlResponse: urlResponse, error: error)
        
        XCTAssertNil(MockMainRequestViewVC.data)
        XCTAssertNil(MockMainRequestViewVC.urlResponse)
        XCTAssertNotNil(MockMainRequestViewVC.error)
    }
    
}
