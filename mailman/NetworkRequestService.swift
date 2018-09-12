import Foundation

protocol NetworkRequestServiceDelegate: class {
    func errorRetrieved(error: Error)
    func responseRetrieved(urlResponse: URLResponse, data: Data)
}

class NetworkRequestService {    
    weak var delegate: NetworkRequestServiceDelegate?
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func sendRequest(requestData: RequestData) {
        guard let url = url(from: requestData) else { return }
        
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = method(from: requestData).rawValue
        request.httpBody = body(from: requestData).data(using: .utf8)
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: completion)
        dataTask.resume()
    }
    
    func completion(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if let error = error {
            delegate?.errorRetrieved(error: error)
        } else if let data = data, let urlResponse = urlResponse {
            delegate?.responseRetrieved(urlResponse: urlResponse, data: data)
        }
    }
    
    private func url(from requestData: RequestData) -> URL? {
        guard
            let textUrl = requestData.url,
            let url = URL(string: textUrl)
            else { return nil }
        return url
    }
    
    private func method(from requestData: RequestData) -> Method {
        guard let method = requestData.method else { return .get}
        return method
    }
    
    private func body(from requestData: RequestData) -> String {
        guard let body = requestData.body else { return "" }
        return body
    }
    
    static func isValid(requestData: RequestData) -> Bool {
        guard let text = requestData.url else {
            return false
        }
        return !text.isEmpty && requestData.method != nil
    }
}
