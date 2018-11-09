import Foundation

public class MockNetworkRequestServiceDelegate: NetworkRequestServiceDelegate {
    var error: Error? = nil
    var urlResponse: URLResponse? = nil
    var data: Any? = nil

    func errorRetrieved(error: Error) {
        self.error = error
    }

    func responseRetrieved(urlResponse: URLResponse, data: Any?) {
        self.urlResponse = urlResponse
        self.data = data
    }
    
    func clearValues() {
        self.error = nil
        self.urlResponse = nil
        self.data = nil
    }
}
