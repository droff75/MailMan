@testable import mailman
import XCTest

class NetworkRequestModelTests: XCTestCase {
    var mockSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
    }
    
    func testWhenSendRequestReceivesValidRequestDataTheCorrectURLIsUsed() {
        let subject = NetworkRequestService(session: mockSession)
        let request = URLRequest(url: URL(string: "test.url")!)
        
        subject.sendRequest(request)
        
        XCTAssertEqual(mockSession.lastURL?.url, request.url)
    }
    
    func testWhenSendRequestCalledRequestIsStarted() {
        let subject = NetworkRequestService(session: mockSession)
        let dataTask = MockURLSessionDataTask()
        let request = URLRequest(url: URL(string: "test.url")!)
        mockSession.nextDataTask = dataTask
        
        subject.sendRequest(request)
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testWhenSendRequestIsCalledHandleSuccessPassesTheExpectedData() {
        let service = NetworkRequestService(session: mockSession)
        let testDelegate = MockNetworkRequestServiceDelegate()
        let expectation = XCTestExpectation(description: "Response")
        let expectedData = "{\"test\":\"test1\"}".data(using: .utf8)
        let expectedUrlResponse = URLResponse.init(url: URL(string: "http://test.url")!, mimeType: "testMimeType", expectedContentLength: 1, textEncodingName: "testEncoding")
        
        mockSession.response = expectedUrlResponse
        mockSession.data = expectedData
        
        var request = URLRequest(url: URL(string: "test.url")!)
        
        func handleSuccess(response: URLResponse, json: [String:Any]?) {
            let actualData = try? JSONSerialization.data(withJSONObject: json!, options: [])
            XCTAssertEqual(response, expectedUrlResponse)
            XCTAssertEqual(actualData, expectedData)
            expectation.fulfill()
        }
        
        service.sendRequest(request, handleSuccess: handleSuccess)
    }
    
    func testWhenSendRequestIsCalledHandleErrorPassesTheExpectedData() {
        let service = NetworkRequestService(session: mockSession)
        let testDelegate = MockNetworkRequestServiceDelegate()
        let expectedError = NSError.init(domain: "testDomain", code: 999, userInfo: nil)
        let expectation = XCTestExpectation(description: "Response")
        
        mockSession.error = expectedError
        
        var request = URLRequest(url: URL(string: "test.url")!)
        
        func handleError(error: Error) {
            XCTAssertEqual(error as NSError, expectedError)
            expectation.fulfill()
        }
    }
    
}
