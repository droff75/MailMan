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
    
    func testNumberOfSectionsReturnsCorrectValue() {
        let postmanInfo = PostmanInfo(postmanId: "", name: "", schema: "")
        let collection = PostmanCollection(info: postmanInfo, items: [])
        
        XCTAssertEqual(PostmanCollectionViewModel(postmanCollections: []).numberOfSections, 0)
        XCTAssertEqual(PostmanCollectionViewModel(postmanCollections: [collection, collection]).numberOfSections, 2)
        XCTAssertEqual(PostmanCollectionViewModel(postmanCollections: [collection, collection, collection, collection]).numberOfSections, 4)
    }
    
    func testNumberOfRowsInSectionReturnsCorrectValue() {
        let postmanInfo = PostmanInfo(postmanId: "", name: "", schema: "")
        let item = Item.folder(PostmanFolder(name: "", items: []))
        let collectionFourItems = PostmanCollection(info: postmanInfo, items: [item, item, item, item])
        let collectionSevenItems = PostmanCollection(info: postmanInfo, items: [item, item, item, item, item, item, item,])
        
        let testObject = PostmanCollectionViewModel(postmanCollections: [collectionFourItems,collectionSevenItems])
        
        XCTAssertEqual(testObject.numberOfRows(inSection: 0), 4)
        XCTAssertEqual(testObject.numberOfRows(inSection: 1), 7)
    
    }
    
    func testNumberOfRowsInSectionReturns0WhenInitializedWithEmptyArray() {
        let testObject = PostmanCollectionViewModel(postmanCollections: [])
        
        XCTAssertEqual(testObject.numberOfRows(inSection: 0), 0)        
    }
}


