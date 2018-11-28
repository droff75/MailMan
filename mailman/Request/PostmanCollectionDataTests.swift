@testable import mailman

import XCTest

class PostmanCollectionDataTests: XCTestCase {

    func testValidJsonSetsCorrectPostmanCollectionDataValues() throws {
        if let data = self.data(forResource: "testJson", withExtension: "json") {
            let jsonData = try JSONDecoder().decode(PostmanCollection.self, from: data)
            
            XCTAssertEqual(jsonData, samplePostmanCollection())
        } else {
            XCTFail("Could not get data from file: testJson.json")
        }
    }
    
    func samplePostmanCollection() -> PostmanCollection {
        let postmanUrl = PostmanUrl(raw: "https://postman-echo.com/post", httpProtocol: "https", host: ["postman-echo","com"], path: ["post"])
        let body = Body(mode: "raw", raw: "{\"this is a test\":\"test\"}")
        let headers = [Header(key: "key1", value: "value1"), Header(key: "key2", value: "value2"), Header.empty, Header(key: "Content-Type", value: "application/json")]
        let requestData = RequestData(url: postmanUrl, method: .post, body: body, headers: headers)
        let itemData = PostmanItem(name: "test post", request: requestData)
        let infoData = PostmanInfo(postmanId: "020b0e16-4d90-4312-8935-18474de30244", name: "test", schema: "https://schema.getpostman.com/json/collection/v2.1.0/collection.json")
        
        
        return PostmanCollection(info: infoData, item: [itemData])
    }
    
}
