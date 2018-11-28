import Foundation

struct PostmanCollection: Codable, Equatable {
    let info: PostmanInfo
    let item: [PostmanItem]
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


