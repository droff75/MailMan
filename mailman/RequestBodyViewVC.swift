import UIKit

class RequestBodyViewVC: UIViewController {
    private let model = NetworkRequestModel()
    private let bodyView = RequestBodyView()
    
    override func loadView() {
        self.view = bodyView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyView.delegate = self
    }
}

extension RequestBodyViewVC: RequestBodyViewDelegate {
    func dismissBodyView() {
        self.dismiss(animated: true, completion: nil)
    }
}
