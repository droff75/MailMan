import Foundation

public class MockNetworkRequestServiceDelegate: NetworkRequestServiceDelegate {
    static var error: Error? = nil
    static var urlResponse: URLResponse? = nil
    static var data: Data? = nil

    func errorRetrieved(error: Error) {
        MockNetworkRequestServiceDelegate.error = error
    }

    func responseRetrieved(urlResponse: URLResponse, data: Data) {
        MockNetworkRequestServiceDelegate.urlResponse = urlResponse
        MockNetworkRequestServiceDelegate.data = data
    }


}
