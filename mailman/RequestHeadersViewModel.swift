import Foundation

class RequestHeadersViewModel {
    var headers: [Header] = []
    
    init(headers: [Int: Header]) {
        self.headers = headersArray(headers: headers)
    }
    
    private func headersArray(headers: [Int: Header]) -> [Header] {
        guard let maxIndex = headers.keys.max() else {
            return [Header.empty]
        }
        var headerArray: [Header] = []
        for index in 0...maxIndex {
            headerArray.append(headers[index] ?? Header.empty)
        }
        
        return headerArray
    }
}
