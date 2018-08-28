import Foundation

protocol NetworkRequestModelDelegate: class {
    func dataRetrieved(data: Data)
    func errorRetrieved(error: Error)
}

class NetworkRequestModel {
    
    weak var delegate: NetworkRequestModelDelegate?
    
    func sendRequest(requestData: RequestData) {
        guard
            let text = requestData.url,
            let url = URL(string: text),
            let method = requestData.method
            else { return }
        let request = NSMutableURLRequest(url: url)
        
        
        request.httpMethod = method.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: completion)
        dataTask.resume()
    }
    
    private func completion(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if let error = error {
            delegate?.errorRetrieved(error: error)
        } else if let data = data {
            delegate?.dataRetrieved(data: data)
        }
    }
    
    static func isValid(requestData: RequestData) -> Bool {
        guard let text = requestData.url, !text.isEmpty, requestData.method != nil else {
            return false
        }
        return true
    }
}
