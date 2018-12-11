import XCTest
@testable import mailman

class PostmanCollectionViewModelTests: XCTestCase {
    
    func testCorrectCellDataReturnedFromPostmanCollection() {
        let info = PostmanInfo(postmanId: "123", name: "test", schema: "test")
        let expectedRequestData = PostmanRequest(name: "testRequest", request: RequestData(url: PostmanUrl(raw: "test.url", httpProtocol: nil, host: nil, path: nil), method: .get, body: nil, headers: nil))
        let requestItem = Item.request(expectedRequestData)
        let emptyFolderItem = Item.folder(PostmanFolder(name: "testFolder2", items: []))
        let folderItem = Item.folder(PostmanFolder(name: "testFolder", items: [emptyFolderItem,requestItem]))
        let collection = PostmanCollection(info: info, items: [folderItem])
        let model = PostmanCollectionViewModel(postmanCollections: [collection])

        XCTAssertEqual(model.data(for: IndexPath(row: 0, section: 0)), CellData(type: .folder("testFolder"), indent: 0))
        XCTAssertEqual(model.data(for: IndexPath(row: 1, section: 0)), CellData(type: .folder("testFolder2"), indent: 1))
        XCTAssertEqual(model.data(for: IndexPath(row: 2, section: 0)), CellData(type: .request(expectedRequestData), indent: 1))
    }
}
class PostmanCollectionViewDataTests: XCTestCase {
    
    func testCorrectCellDataReturnedFromPostmanCollection() {
        let info = PostmanInfo(postmanId: "123", name: "test", schema: "test")
        let expectedRequestData = PostmanRequest(name: "testRequest", request: RequestData(url: PostmanUrl(raw: "test.url", httpProtocol: nil, host: nil, path: nil), method: .get, body: nil, headers: nil))
        let requestItem = Item.request(expectedRequestData)
        
        let nestedRequest = Item.request(expectedRequestData)
        let child3NestedFolder = Item.folder(PostmanFolder(name: "testFolder6", items: [nestedRequest]))
        let child2NestedFolder = Item.folder(PostmanFolder(name: "testFolder5", items: [child3NestedFolder]))
        let child1NestedFolder = Item.folder(PostmanFolder(name: "testFolder4", items: [child2NestedFolder]))
        let parentNestedFolder = Item.folder(PostmanFolder(name: "testFolder3", items: [child1NestedFolder]))
        let emptyFolderItem = Item.folder(PostmanFolder(name: "testFolder2", items: []))
        let folderItem = Item.folder(PostmanFolder(name: "testFolder", items: [emptyFolderItem,requestItem, parentNestedFolder]))
        let collection = PostmanCollection(info: info, items: [folderItem])
        
        
        let expectedRows = [CellData(type: .folder("testFolder"), indent: 0),
                            CellData(type: .folder("testFolder2"), indent: 1),
                            CellData(type: .request(expectedRequestData), indent: 1),
                            CellData(type: .folder("testFolder3"), indent: 1),
                            CellData(type: .folder("testFolder4"), indent: 2),
                            CellData(type: .folder("testFolder5"), indent: 3),
                            CellData(type: .folder("testFolder6"), indent: 4),
                            CellData(type: .request(expectedRequestData), indent: 5)]

        let testObject = PostmanCollectionViewData(postmanCollection: collection)
        
        XCTAssertEqual(testObject.sectionTitle, collection.info.name)
        XCTAssertEqual(testObject.rows, expectedRows)
    }
}
