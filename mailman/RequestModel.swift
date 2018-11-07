import Foundation

class RequestModel {
    
    private let networkService: NetworkRequestService
    
    init(networkService: NetworkRequestService = NetworkRequestService()) {
        self.networkService = networkService
    }
    let headersModel = HeadersModel()
    var method: Method = .get
    var url: String = ""
    var body: String?
    var headers: [Header]? {
        return headersModel.headersArray
    }
    
    func sendRequest() {
        ///////////////////////////////////////////////
        networkService.sendRequest(urlRequest()!)
    }
    
    func urlRequest() -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body?.data(using: .utf8)
        request.allHTTPHeaderFields = requestHeaders(headers: headers)
        
        return request
    }
    
    private func requestHeaders(headers: [Header]?) -> [String:String] {
        var headersDictionary = [String:String]()
        headers?.forEach { header in
            headersDictionary[header.key!] = header.value
        }
        
        return headersDictionary
    }
}
