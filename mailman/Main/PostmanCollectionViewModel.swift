import Foundation

struct PostmanCollectionViewModel {
    private let collectionData: [PostmanCollectionViewData]
    
    init(postmanCollections: [PostmanCollection]) {
        collectionData = postmanCollections.map(PostmanCollectionViewData.init)
    }
    
    func data(for indexPath: IndexPath) -> CellData? {
        guard let sectionViewData = viewData(forSection: indexPath.section),
            indexPath.row < sectionViewData.rows.count else { return nil }
        return sectionViewData.rows[indexPath.row]
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return viewData(forSection: section)?.rows.count ?? 0
    }
    
    func title(forSection section: Int) -> String? {
        return viewData(forSection: section)?.sectionTitle
    }
    
    var numberOfSections: Int {
        return collectionData.count
    }
    
    private func viewData(forSection section: Int) -> PostmanCollectionViewData? {
        guard section < collectionData.count else { return nil }
        return collectionData[section]
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
    var name: String {
        switch type {
        case .folder(let name):
            return name
        case .request(let request):
            return request.name
        }
    }
}

enum RowType: Equatable {
    case folder(String)
    case request(PostmanRequest)
}
