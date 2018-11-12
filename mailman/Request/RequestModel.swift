import Foundation

class RequestModel {
    
    private let networkService: NetworkRequestService
    
    init(networkService: NetworkRequestService = NetworkRequestService()) {
        self.networkService = networkService
    }
    var headers: [Header] = []
    var method: Method = .get
    var url: String = ""
    var body: String?
    
    func sendRequest() {
        guard let urlRequest = urlRequest() else { return }
        networkService.sendRequest(urlRequest)
    }
    
    func urlRequest() -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body?.data(using: .utf8)
        request.allHTTPHeaderFields = requestHeaders()
        
        return request
    }
    
    func isValid() -> Bool {
        return !url.isEmpty
    }
    
    private func requestHeaders() -> [String:String] {
        var headersDictionary = [String:String]()
        headers.forEach { header in
            if let key = header.key, !key.isEmpty {
                headersDictionary[key] = header.value ?? ""
            }
        }
        
        return headersDictionary
    }
}
