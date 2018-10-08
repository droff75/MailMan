import UIKit

class MainRequestViewVC: UIViewController {    
    private let service = NetworkRequestService()
    fileprivate var headersModel: HeadersModel?
    private var mainView: MainRequestView
    fileprivate var requestModel: RequestModel
    
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
    
    func responseRetrieved(urlResponse: URLResponse, data: Any?) {
        DispatchQueue.main.async { [weak self] in
            let httpResponse = urlResponse as! HTTPURLResponse
            let statusCode = String(httpResponse.statusCode)
            self?.mainView.update(statusCode: statusCode, response: data)
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
        newViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(bodyDoneButtonTapped))
        let navController = UINavigationController(rootViewController: newViewController)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func showHeadersView() {
        let headersModel = HeadersModel(headers: requestModel.headers ?? [:])
        let newViewController = RequestHeadersViewVC(headerModel: headersModel)
        newViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(headersDoneButtonTapped))
        newViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(headersCancelButtonTapped))
        let navController = UINavigationController(rootViewController: newViewController)
        
        self.present(navController, animated: true, completion: nil)
        self.headersModel = headersModel
    }
    
    @objc
    private func headersDoneButtonTapped() {
        guard let headersModel = headersModel else {
            dismiss(animated: true, completion: nil)
            return
        }
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        requestModel.headers = headersModel.headers
        dismiss(animated: true, completion: nil)
        self.headersModel = nil
    }
    
    @objc
    private func headersCancelButtonTapped() {
        dismiss(animated: true, completion: nil)
        self.headersModel = nil
    }
    
    @objc
    private func bodyDoneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension MainRequestViewVC: RequestBodyViewDelegate {
    func bodyChanged(_ body: String) {
        
    }
    
    
}


