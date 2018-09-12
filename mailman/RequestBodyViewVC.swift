import UIKit

class RequestBodyViewVC: UIViewController {
    private let requestModel: RequestModel
    private let bodyView = RequestBodyView()
    
    
    init(requestModel: RequestModel) {
        self.requestModel = requestModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    func bodyChanged(_ body: String) {
        requestModel.body = body
    }
}
