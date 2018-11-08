@testable import mailman
import XCTest

class RequestDataTests: XCTestCase {

    func testValidJsonSetsCorrectRequestDataValues() throws {
        if let data = self.data(forResource: "testJson", withExtension: "json") {
            let jsonData = try JSONDecoder().decode(RequestData.self, from: data)
            let postmanUrl = PostmanUrl(raw: "https://postman-echo.com/post", httpProtocol: "https", host: ["postman-echo","com"], path: ["post"])
            let expectedData = RequestData(url: postmanUrl, method: .post, body: Body(mode: "raw", raw: "this is a test"), headers: [Header(key: "test1", value: "test11"), Header(key: "test2", value: "test22"), Header.empty, Header.empty, Header(key: "test3", value: "")])
            XCTAssertEqual(jsonData, expectedData)
        } else {
            XCTFail("Could not get data from file: Thing.json")
        }
    }
    
}
