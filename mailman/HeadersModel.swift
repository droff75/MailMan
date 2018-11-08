import Foundation

struct Header: Codable, Equatable {
    let key: String?
    let value: String?
    
    static var empty: Header {
        return Header(key: "", value: "")
    }
}

class HeadersModel {
    private(set) var headers: [Int:Header]
    
    init(headers: [Int:Header] = [:]) {
        self.headers = headers
    }
    
    func update(header: Header, at index: Int) {
        if header == Header.empty {
            headers.removeValue(forKey: index)
        } else {
            headers[index] = header
        }
    }
}
