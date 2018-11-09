import UIKit

class RequestBodyViewController: UIViewController {
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
        bodyView.set(body: requestModel.body)
        bodyView.delegate = self
    }
}

extension RequestBodyViewController: RequestBodyViewDelegate {
    func bodyChanged(_ body: String) {
        requestModel.body = body
    }
}
