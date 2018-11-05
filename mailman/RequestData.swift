import Foundation

struct RequestData: Codable {
    let url: String?
    let method: Method?
    let body: String?
    let headers: [Header]?
    
    enum CodingKeys: String, CodingKey {
        case url
        case method
        case body
        case headers = "header"
    }
    
    func urlRequest() -> URLRequest? {
        guard let urlString = url, let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        if let method = method {
            request.httpMethod = method.rawValue
        } else {
            request.httpMethod = "GET"
        }
        request.httpBody = body?.data(using: .utf8)
//        request.allHTTPHeaderFields = 
        return request
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


