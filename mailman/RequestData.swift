import Foundation

struct RequestData {
    let url: String?
    let method: Method?
    let body: String?
    let headers: [String:String]?
}

enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

let methodTypes: [Method] = [.get, .post, .put, .patch, .delete]

