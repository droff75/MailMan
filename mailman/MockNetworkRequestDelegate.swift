import Foundation

public class MockMainRequestViewVC: NetworkRequestServiceDelegate {
    static var error: Error? = nil
    static var urlResponse: URLResponse? = nil
    static var data: Data? = nil

    func errorRetrieved(error: Error) {
        MockMainRequestViewVC.error = error
    }

    func responseRetrieved(urlResponse: URLResponse, data: Data) {
        MockMainRequestViewVC.urlResponse = urlResponse
        MockMainRequestViewVC.data = data
    }


}
