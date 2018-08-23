import Foundation

protocol NetworkRequestModelDelegate: class {
    func dataRetrieved(data: Data)
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
            print(error)
        } else if let data = data {
            delegate?.dataRetrieved(data: data)
        }
    }
}
