import Foundation

protocol NetworkRequestModelDelegate: class {
    func dataRetrieved(data: Data)
    func errorRetrieved(error: Error)
}

class NetworkRequestModel {
    
    weak var delegate: NetworkRequestModelDelegate?
    
    func sendRequest(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: completion)
        dataTask.resume()
    }
    
    private func completion(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if let error = error {
            delegate?.errorRetrieved(error: error)
        } else if let data = data {
            delegate?.dataRetrieved(data: data)
        }
    }
}
