import Foundation

class NetworkRequestService {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func sendRequest(_ request: URLRequest, handleSuccess: @escaping (URLResponse, [String:Any]?)->() = {_,_ in }, handleError: @escaping (Error)->() = {_ in }) {
        let dataTask = session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                handleError(error)
            } else if let data = data, let response = response {
                handleSuccess(response, self?.parseJsonResponse(data: data))
            }
        }
        dataTask.resume()
    }
    
    private func parseJsonResponse(data: Data) -> [String:Any]? {
        var jsonResponse: [String:Any]?
        do {
            jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
        } catch let parsingError {
            print("Error", parsingError)
        }
        return jsonResponse
    }
}
