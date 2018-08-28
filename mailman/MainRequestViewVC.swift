import UIKit

class MainRequestViewVC: UIViewController {
    
    private let model = NetworkRequestModel()
    private let mainView = MainRequestView()

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
    func dataRetrieved(data: Data) {
        DispatchQueue.main.async { [weak self] in
            let stringData = String(data: data, encoding: .utf8)
            self?.mainView.update(response: stringData)
        }
    }
    
    func errorRetrieved(error: Error) {
        DispatchQueue.main.async { [weak self] in
            let stringError = error.localizedDescription
            self?.mainView.update(response: stringError)
        }
    }
}

extension MainRequestViewVC: MainRequestViewDelegate {
    func sendURL(url: String) {
        model.sendRequest(urlString: url)
    }
}


