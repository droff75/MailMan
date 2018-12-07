import Foundation

enum Item: Codable, Equatable{
    case folder(PostmanFolder)
    case postmanItem(PostmanItem)
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let folder = try? container.decode(PostmanFolder.self) {
            self = .folder(folder)
        } else if let item = try? container.decode(PostmanItem.self) {
            self = .postmanItem(item)
        } else {
            self = .unknown
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .folder(let postmanFolder):
            try container.encode(postmanFolder)
        case .postmanItem(let postmanItem):
            try container.encode(postmanItem)
        default:
            break
        }
    }
}

struct PostmanCollection: Codable, Equatable {
    let info: PostmanInfo
    let item: [Item]
}

struct PostmanInfo: Codable, Equatable {
    let postmanId: String
    let name: String
    let schema: String
    
    enum CodingKeys: String, CodingKey {
        case postmanId = "_postman_id"
        case name
        case schema
    }
}

struct PostmanItem: Codable, Equatable {
    let name: String
    let request: RequestData
}

struct PostmanFolder: Codable, Equatable {
    let name: String
    let item: [Item]
}

struct RequestData: Codable, Equatable {
    let url: PostmanUrl?
    let method: Method?
    let body: Body?
    let headers: [Header]?
    
    enum CodingKeys: String, CodingKey {
        case url
        case method
        case body
        case headers = "header"
    }
}

struct Body: Codable, Equatable {
    let mode: String?
    let raw: String?
}

struct PostmanUrl: Codable, Equatable {
    let raw: String?
    let httpProtocol: String?
    let host: [String]?
    let path: [String]?
    
    enum CodingKeys: String, CodingKey {
        case raw
        case httpProtocol = "protocol"
        case host
        case path
    }
}

enum Method: String, Codable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"

    static let types: [Method] = [.get, .post, .put, .patch, .delete]
}
