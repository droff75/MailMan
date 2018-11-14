import UIKit

class MainRequestViewController: UIViewController {    
    private let service = NetworkRequestService()
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

extension MainRequestViewController: NetworkRequestServiceDelegate {    
    func errorRetrieved(error: Error) {
        DispatchQueue.main.async { [weak self] in
            let stringError = error.localizedDescription
            self?.mainView.update(errorResponse: stringError)
        }
    }
    
    func responseRetrieved(urlResponse: URLResponse, data: Any?) {
        DispatchQueue.main.async { [weak self] in
            let httpResponse = urlResponse as! HTTPURLResponse
//            let statusCode = String(httpResponse.statusCode)
            let statusCode = httpResponse.statusCode
            self?.mainView.update(statusCode: statusCode, response: data)
        }
    }
}

extension MainRequestViewController: MainRequestViewDelegate {    
    func urlChanged(_ url: String) {
        requestModel.url = url
        mainView.update(buttonEnabled: requestModel.isValid())
    }
    
    func send() {
        requestModel.sendRequest()
    }
    
    func showMethodPopover(sender: UIView) {
        let methodPopoverViewController = MethodPopoverViewController()
        methodPopoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
        methodPopoverViewController.preferredContentSize = CGSize(width: 200, height: 220)
        methodPopoverViewController.delegate = self
        
        self.present(methodPopoverViewController, animated: true, completion: nil)
        
        let popoverPresentationController = methodPopoverViewController.popoverPresentationController
        popoverPresentationController?.sourceView = sender
        popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: sender.frame.size.width, height: sender.frame.size.height)
    }
    
    func showBodyView() {
        let bodyViewController = RequestBodyViewController(requestModel: requestModel)
        bodyViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(bodyDoneButtonTapped))
        let navController = UINavigationController(rootViewController: bodyViewController)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func showHeadersView() {
        let headersViewController = RequestHeadersViewController(headers: requestModel.headers)
        headersViewController.delegate = self
        headersViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(headersDoneButtonTapped))
        headersViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(headersCancelButtonTapped))
        let navController = UINavigationController(rootViewController: headersViewController)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc
    private func headersDoneButtonTapped() {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func headersCancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func bodyDoneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension MainRequestViewController: RequestBodyViewDelegate {
    func bodyChanged(_ body: String) {
        
    }
}

extension MainRequestViewController: RequestHeaderViewControllerDelegate {
    func headersUpdated(_ headers: [Header]) {
        requestModel.headers = headers
    }   
}

extension MainRequestViewController: MethodPopoverViewControllerDelegate {
    func update(method: Method) {
        requestModel.method = method
        mainView.update(method: method.rawValue)
    }
}


