import UIKit
import MobileCoreServices

class MainRequestViewController: UIViewController {    
    private let service = NetworkRequestService()
    private var mainView: MainView
    private var hasKeyboard: Bool?
    private let notificationCenter = NotificationCenter.default
    fileprivate var requestModel: RequestModel
    fileprivate var responseCode: HTTPStatusCode?
    fileprivate var postmanCollections: [PostmanCollection] = []
    fileprivate let userDefaults: UserDefaults
    
    init() {
        mainView = MainView()
        requestModel = RequestModel(networkService: service)
        userDefaults = UserDefaults.standard
        super.init(nibName: nil, bundle: nil)
        
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidDismiss), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        if let persistedCollections = userDefaults.data(forKey: "PostmanCollections") {
            parsePostmanCollection(collection: persistedCollections)
        }
        mainView.update(postmanCollections: postmanCollections)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        mainView.delegate = self
        mainView.update(url: requestModel.url)
        mainView.update(buttonEnabled: requestModel.isValid())
        view = mainView
    }
    
    private func update(from requestData: RequestData) {
        requestModel = RequestModel(requestData: requestData)
        mainView.update(url: requestModel.url)
        mainView.update(method: requestModel.method.rawValue)
        mainView.clearResponse()
    }
    
    @objc
    func keyboardDidShow(notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyboardFrame = userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let keyboard = self.view.convert(keyboardFrame, from: self.view.window)
        let height = self.view.frame.size.height
        let toolbarHeight = height - keyboard.origin.y
        
        if keyboard.origin.y + keyboard.size.height > height {
            self.hasKeyboard = true
            self.mainView.adjustViewForToolbar(toolbarHeight: toolbarHeight)
        } else {
            self.hasKeyboard = false
            self.mainView.adjustViewForToolbar(toolbarHeight: toolbarHeight)
        }
    }
    
    @objc
    func keyboardDidDismiss() {
        mainView.adjustViewForKeyboardDismissed()
    }
    
    func parsePostmanCollection(collection: Data) {
        if let postmanCollection = try? JSONDecoder().decode(PostmanCollection.self, from: collection) {
            self.postmanCollections = [postmanCollection]
        } else {
            self.postmanCollections = []
        }
    }
}

extension MainRequestViewController: MainViewDelegate {
    func requestSelected(request: RequestData) {
        update(from: request)
    }
    
    func urlChanged(_ url: String) {
        requestModel.url = url
        mainView.update(buttonEnabled: requestModel.isValid())
    }
    
    func send() {
        func handleSuccess(response: URLResponse, data: [String : Any]?) {
            DispatchQueue.main.async { [weak self] in
                let httpResponse = response as! HTTPURLResponse
                let statusCode = HTTPStatusCode(rawValue: httpResponse.statusCode)
                
                self?.responseCode = statusCode
                self?.mainView.update(statusCode: statusCode, response: data)
            }
        }
        
        func handleError(error: Error) {
            DispatchQueue.main.async { [weak self] in
                let stringError = error.localizedDescription
                self?.mainView.update(errorResponse: stringError)
            }
        }
        requestModel.sendRequest(success: handleSuccess, error: handleError)
    }
    
    func showMethodPopover(sender: UIView) {
        let methodPopoverViewController = MethodPopoverViewController()
        methodPopoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
        methodPopoverViewController.preferredContentSize = CGSize(width: 200, height: 220)
        methodPopoverViewController.delegate = self
        
        self.present(methodPopoverViewController, animated: true, completion: nil)
        
        let popoverPresentationController = methodPopoverViewController.popoverPresentationController
        popoverPresentationController?.sourceView = sender
        popoverPresentationController?.sourceRect = sender.bounds
    }
    
    func showResponseCodePopover(sender: UIView) {
        guard let responseCode = responseCode else { return }
        let responseCodePopoverViewController = TextPopoverViewController(popoverText: responseCode.responseDefinition)
        responseCodePopoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
        responseCodePopoverViewController.preferredContentSize = CGSize(width: 200, height: 200)
        responseCodePopoverViewController.popoverPresentationController?.delegate = self
        
        self.present(responseCodePopoverViewController, animated: true, completion: nil)
        
        let popoverPresentationController = responseCodePopoverViewController.popoverPresentationController
        popoverPresentationController?.sourceView = sender
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.sourceRect = sender.bounds
    }
    
    func showBodyView() {
        let bodyViewController = RequestBodyViewController(requestModel: requestModel)
        bodyViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(bodyDoneButtonTapped))
        bodyViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(bodyCancelButtonTapped))
        
        let navController = UINavigationController(rootViewController: bodyViewController)
        navController.modalPresentationStyle = .formSheet
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func showHeadersView() {
        let headersViewController = RequestHeadersViewController(headers: requestModel.headers)
        headersViewController.delegate = self
        headersViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(headersDoneButtonTapped))
        headersViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(headersCancelButtonTapped))
        let navController = UINavigationController(rootViewController: headersViewController)
        navController.modalPresentationStyle = .formSheet
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func importSelected() {
        let importMenu = UIDocumentPickerViewController(documentTypes: [kUTTypeJSON as String], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.show(importMenu, sender: nil)
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
    
    @objc
    private func bodyCancelButtonTapped() {
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

extension MainRequestViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let data = try? Data(contentsOf: urls[0], options: []) else { return }
        
        _ = parsePostmanCollection(collection: data)
        mainView.update(postmanCollections: postmanCollections)
        userDefaults.set(data, forKey: "PostmanCollections")
    }
}

extension MainRequestViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

