import Foundation

struct Header {
    let key: String?
    let value: String?
}

class HeadersModel {
    var headers: [Int:Header]
    
    init(headers: [Int:Header] = [:]) {
        self.headers = headers
    }
    
    func update(header: Header, at index: Int) {
        headers[index] = header
    }
}
