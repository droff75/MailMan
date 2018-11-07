@testable import mailman
import XCTest

class NetworkRequestModelTests: XCTestCase {
    var session: MockURLSession!
    
    override func setUp() {
        super.setUp()
        session = MockURLSession()
    }

    func testIsValidReturnsFalseWhenUrlIsEmpty() {
        XCTAssertFalse(NetworkRequestService.isValid(requestData: RequestData(url: nil, method: .get, body: "", headers: nil)))
        XCTAssertFalse(NetworkRequestService.isValid(requestData: RequestData(url: "", method: .get, body: "", headers: nil)))
    }
    
    func testIsValidReturnsFalseWhenMethodIsNil() {
        XCTAssertFalse(NetworkRequestService.isValid(requestData: RequestData(url: "http://test.url", method: nil, body: "", headers: nil)))
    }
    
    func testIsValidReturnsTrueWhenRequestDataIsValid() {
        XCTAssertTrue(NetworkRequestService.isValid(requestData: RequestData(url: "http://test.url", method: .get, body: "", headers: nil)))
    }
    
    func testWhenSendRequestReceivesValidRequestDataTheCorrectURLIsUsed() {
        let subject = NetworkRequestService(session: session)
        let request = URLRequest(url: URL(string: "test.url")!)
        
        subject.sendRequest(request)
        
        XCTAssertEqual(session.lastURL?.url, request.url)
    }
    
    func testWhenSendRequestCalledRequestIsStarted() {
        let subject = NetworkRequestService(session: session)
        let dataTask = MockURLSessionDataTask()
        let request = URLRequest(url: URL(string: "test.url")!)
        session.nextDataTask = dataTask
        
        subject.sendRequest(request)
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testWhenCompletionCalledWithValidDataAndResponseThenCorrectDelegateFunctionIsCalled() {
        let service = NetworkRequestService(session: session)
        let testDelegate = MockNetworkRequestServiceDelegate()
        service.delegate = testDelegate
        
        let data = "{\"test\":\"test1\"}".data(using: .utf8)
        let urlResponse = URLResponse.init(url: URL(string: "http://test.url")!, mimeType: "testMimeType", expectedContentLength: 1, textEncodingName: "testEncoding")
        let error = Error?.init(nilLiteral: ())
        
        service.completion(data: data, urlResponse: urlResponse, error: error)
        XCTAssertNotNil(testDelegate.data)
        XCTAssertNotNil(testDelegate.urlResponse)
        XCTAssertNil(testDelegate.error)
    }
    
    func testWhenCompletionCalledWithErrorThenCorrectDelegateFunctionIsCalled() {
        let service = NetworkRequestService(session: session)
        let testDelegate = MockNetworkRequestServiceDelegate()
        service.delegate = testDelegate
        
        let data = Data?.init(nilLiteral: ())
        let urlResponse = URLResponse?.init(nilLiteral: ())
        let error = NSError.init(domain: "testDomain", code: 999, userInfo: nil)
        
        service.completion(data: data, urlResponse: urlResponse, error: error)
        
        XCTAssertNil(testDelegate.data)
        XCTAssertNil(testDelegate.urlResponse)
        XCTAssertNotNil(testDelegate.error)
    }
    
}
