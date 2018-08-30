import UIKit

class MainRequestViewVC: UIViewController {
    
    private let model = NetworkRequestModel()
    fileprivate let mainView = MainRequestView()

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.delegate = self
        mainView.delegate = self
    }
}

extension MainRequestViewVC: NetworkRequestModelDelegate {
//    func dataRetrieved(data: Data) {
//        DispatchQueue.main.async { [weak self] in
//            let stringData = String(data: data, encoding: .utf8)
//            self?.mainView.update(response: stringData)
//        }
//    }
    
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
    func valueChanged(requestData: RequestData) {
        let isValid = NetworkRequestModel.isValid(requestData: requestData)
        mainView.update(buttonEnabled: isValid)
    }
    
    func send(requestData: RequestData) {
        model.sendRequest(requestData: requestData)
    }
}


