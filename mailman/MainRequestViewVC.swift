import UIKit

class MainRequestViewVC: UIViewController {
    
    private let service = NetworkRequestService()
    fileprivate let mainView = MainRequestView()
    private let requestModel = RequestModel(networkService: NetworkRequestService())

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.delegate = self
        mainView.delegate = self
    }
}

extension MainRequestViewVC: NetworkRequestServiceDelegate {    
    func errorRetrieved(error: Error) {
        DispatchQueue.main.async { [weak self] in
            let stringError = error.localizedDescription
            self?.mainView.update(errorResponse: stringError)
        }
    }
    
    func responseRetrieved(urlResponse: URLResponse, data: Data) {
        DispatchQueue.main.async { [weak self] in
            let httpResponse = urlResponse as! HTTPURLResponse
            let statusCode = String(httpResponse.statusCode)
            let stringData = String(data: data, encoding: .utf8)
            self?.mainView.update(statusCode: statusCode, response: stringData)
        }
    }
}

extension MainRequestViewVC: MainRequestViewDelegate {
    
    func methodChanged(_ method: Method) {
        requestModel.method = method
    }
    
    func urlChanged(_ url: String) {
        requestModel.url = url
        mainView.update(buttonEnabled: requestModel.url != "")
    }
    
    func send() {
        requestModel.sendRequest()
    }
    
    func showBodyView() {
        let newViewController = RequestBodyViewVC(requestModel: requestModel)
        self.present(newViewController, animated: true, completion: nil)
    }
}


