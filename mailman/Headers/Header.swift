import Foundation

struct Header: Codable, Equatable {
    let key: String?
    let value: String?
    
    static var empty: Header {
        return Header(key: "", value: "")
    }
}
