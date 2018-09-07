import Foundation

struct RequestData {
    let url: String?
    let method: Method?
    let headers: [String:String]?
}

enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
