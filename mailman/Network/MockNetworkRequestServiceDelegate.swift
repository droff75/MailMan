import Foundation

public class MockNetworkRequestServiceDelegate: NetworkRequestServiceDelegate {
    var error: Error? = nil
    var urlResponse: URLResponse? = nil
    var data: [String:Any]? = nil

    func errorRetrieved(error: Error) {
        self.error = error
    }

    func responseRetrieved(urlResponse: URLResponse, data: [String:Any]?) {
        self.urlResponse = urlResponse
        self.data = data
    }
}
