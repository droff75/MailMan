import Foundation

protocol NetworkRequestServiceDelegate: class {
    func errorRetrieved(error: Error)
    func responseRetrieved(urlResponse: URLResponse, data: Any?)
}

class NetworkRequestService {    
    weak var delegate: NetworkRequestServiceDelegate?
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func sendRequest(_ request: URLRequest) {        
        let dataTask = session.dataTask(with: request, completionHandler: completion)
        dataTask.resume()
    }
    
    func completion(data: Data?, urlResponse: URLResponse?, error: Error?) {
        var jsonResponse: Any?
        if let error = error {
            delegate?.errorRetrieved(error: error)
        } else if let data = data, let urlResponse = urlResponse {
            do {
                jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
            } catch let parsingError {
                print("Error", parsingError)
            }
            delegate?.responseRetrieved(urlResponse: urlResponse, data: jsonResponse)

        }
    }
    
    private func url(from requestData: RequestData) -> URL? {
        guard
            let textUrl = requestData.url,
            let url = URL(string: textUrl)
            else { return nil }
        return url
    }
    
    private func body(from requestData: RequestData) -> String {
        guard let body = requestData.body else { return "" }
        return body
    }
    
//    private func headers(from requestData: RequestData) -> [String: String]? {
//        guard let headers = requestData.headers else { return nil }
//        var headersDictionary: [String: String] = [:]
//        headers.forEach { header in
//            guard let key = header.key else { return }
//
//            headersDictionary[key] = header.value
//        }
//    }
    
    static func isValid(requestData: RequestData) -> Bool {
        guard let text = requestData.url else {
            return false
        }
        return !text.isEmpty && requestData.method != nil
    }
}
