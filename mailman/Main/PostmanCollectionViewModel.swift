import Foundation

struct PostmanCollectionViewModel {
    private let collectionData: [PostmanCollectionViewData]
    
    init(postmanCollections: [PostmanCollection]) {
        collectionData = postmanCollections.map(PostmanCollectionViewData.init)
    }
    
    func data(for indexPath: IndexPath) -> CellData {        
        return collectionData[indexPath.section].rows[indexPath.row]
    }
}

struct PostmanCollectionViewData: Equatable {
    let sectionTitle: String
    let rows: [CellData]
    
    init(postmanCollection: PostmanCollection) {
        sectionTitle = postmanCollection.info.name
        rows = PostmanCollectionViewData.cellData(fromItems: postmanCollection.items)
    }
    
    private static func cellData(fromItems items: [Item], indent: Int = 0) -> [CellData] {
        var cellData = [CellData]()
        items.enumerated().forEach { index, item in
            switch item {
            case .folder(let postmanFolder):
                cellData.append(CellData(type: .folder(postmanFolder.name), indent: indent))
                cellData.append(contentsOf: self.cellData(fromItems: postmanFolder.items, indent: indent + 1))
            case .request(let postmanRequest):
                cellData.append(CellData(type: .request(postmanRequest), indent: indent))
            default:
                break
            }
        }
        return cellData
    }
}

struct CellData: Equatable {
    let type: RowType
    let indent: Int
}

enum RowType: Equatable {
    case folder(String)
    case request(PostmanRequest)
}
