import Foundation

class RequestModel {
    
    private let networkService: NetworkRequestService
    
    init(networkService: NetworkRequestService) {
        self.networkService = networkService
    }
    
    var method: Method = .get
    var url: String = ""
    var body: String = ""
    var headers: [Int:Header]?
    
    func sendRequest() {
        let requestData = RequestData(
            url: url,
            method: method,
            body: body,
            headers: headersDictionary()
        )
        
        networkService.sendRequest(requestData: requestData)
    }
    
    private func headersDictionary() -> [String:String] {
        var headersDictionary: [String:String] = [:]
        if let dictionary = headers?.values {
            for values in dictionary {
                guard let key = values.key else { return [:] }
                guard let value = values.value else { return [:] }
                headersDictionary.updateValue(value, forKey: key)
            }
        }
        return headersDictionary
    }
}
