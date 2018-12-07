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
        let postPostmanUrl = PostmanUrl(raw: "https://postman-echo.com/post", httpProtocol: "https", host: ["postman-echo","com"], path: ["post"])
        let getPostmanUrl = PostmanUrl(raw: "https://postman-echo.com/get?key=value", httpProtocol: "https", host: ["postman-echo","com"], path: ["get"])
        let postBody = Body(mode: "raw", raw: "{\"this is a test\":\"test\"}")
        let getBody = Body(mode: "raw", raw: "")
        let headers = [Header(key: "key1", value: "value1"), Header(key: "key2", value: "value2"), Header(key: "key3", value: "value3"), Header(key: "Content-Type", value: "application/json")]
        let postRequestData = RequestData(url: postPostmanUrl, method: .post, body: postBody, headers: headers)
        let getRequestData = RequestData(url: getPostmanUrl, method: .get, body: getBody, headers: [])
        let fourthItem = Item.postmanItem(PostmanItem(name: "test post", request: postRequestData))
        let thirdItem = Item.postmanItem(PostmanItem(name: "test get", request: getRequestData))
        let secondItem = Item.folder(PostmanFolder(name: "Test Folder 2", item: [thirdItem]))
        let firstItem = Item.folder(PostmanFolder(name: "Test Folder 1", item: [secondItem, fourthItem]))
        let infoData = PostmanInfo(postmanId: "020b0e16-4d90-4312-8935-18474de30244", name: "test", schema: "https://schema.getpostman.com/json/collection/v2.1.0/collection.json")
        
        return PostmanCollection(info: infoData, item: [firstItem])
    }    
}
