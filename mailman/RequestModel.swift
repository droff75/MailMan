import Foundation

class RequestModel {
    
    private let networkService: NetworkRequestService
    
    init(networkService: NetworkRequestService) {
        self.networkService = networkService
    }
    
    var method: Method = .get
    var url: String = ""
    var body: String = ""
    
    func sendRequest() {
        let requestData = RequestData(
            url: url,
            method: method,
            body: body
        )
        
        networkService.sendRequest(requestData: requestData)
    }
}
