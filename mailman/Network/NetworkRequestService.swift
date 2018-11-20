import Foundation

protocol NetworkRequestServiceDelegate: class {
    func errorRetrieved(error: Error)
    func responseRetrieved(urlResponse: URLResponse, data: [String:Any]?)
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
        if let error = error {
            delegate?.errorRetrieved(error: error)
        } else if let data = data, let urlResponse = urlResponse {
            var jsonResponse: [String:Any]?
            do {
                jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            } catch let parsingError {
                print("Error", parsingError)
            }
            delegate?.responseRetrieved(urlResponse: urlResponse, data: jsonResponse)

        }
    }
}
