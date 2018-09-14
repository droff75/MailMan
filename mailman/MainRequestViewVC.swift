import UIKit

class MainRequestViewVC: UIViewController {
    
    private let service = NetworkRequestService()
    private var mainView: MainRequestView
    private var requestModel: RequestModel
    
    init() {
        mainView = MainRequestView()
        requestModel = RequestModel(networkService: service)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        service.delegate = self
        mainView.delegate = self
        
        view = mainView
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


