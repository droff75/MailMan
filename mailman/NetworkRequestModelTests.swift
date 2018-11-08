@testable import mailman
import XCTest

class NetworkRequestModelTests: XCTestCase {
    var session: MockURLSession!
    
    override func setUp() {
        super.setUp()
        session = MockURLSession()
    }

    func testIsValidReturnsFalseWhenUrlIsEmpty() {
        let postmanUrl = PostmanUrl(raw: "", httpProtocol: nil, host: nil, path: nil)
        
        XCTAssertFalse(NetworkRequestService.isValid(requestData: RequestData(url: nil, method: .get, body: nil, headers: nil)))
        XCTAssertFalse(NetworkRequestService.isValid(requestData: RequestData(url: postmanUrl, method: .get, body: nil, headers: nil)))
    }
    
    func testIsValidReturnsFalseWhenMethodIsNil() {
        let postmanUrl = PostmanUrl(raw: "test.url", httpProtocol: nil, host: nil, path: nil)

        XCTAssertFalse(NetworkRequestService.isValid(requestData: RequestData(url: postmanUrl, method: nil, body: nil, headers: nil)))
    }
    
    func testIsValidReturnsTrueWhenRequestDataIsValid() {
        let postmanUrl = PostmanUrl(raw: "test.url", httpProtocol: nil, host: nil, path: nil)

        XCTAssertTrue(NetworkRequestService.isValid(requestData: RequestData(url: postmanUrl, method: .get, body: Body(mode: nil, raw: "Test Body"), headers: nil)))
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
