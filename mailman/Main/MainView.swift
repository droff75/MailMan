import UIKit

protocol MainViewDelegate: RequestViewDelegate {
    func importSelected()
}

class MainView: UIView, UITextFieldDelegate {
    weak var delegate: MainViewDelegate?
    
    private let toolbarView = ToolbarView()
    private let requestView = RequestView()
    private let responseView = UITextView()
    private let padding: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        toolbarView.delegate = self
        requestView.delegate = self
        
        addSubview(toolbarView)
        addSubview(requestView)
        addSubview(responseView)
        
        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        toolbarView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        toolbarView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        toolbarView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        toolbarView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        requestView.translatesAutoresizingMaskIntoConstraints = false
        requestView.topAnchor.constraint(equalTo: toolbarView.bottomAnchor, constant: padding).isActive = true
        requestView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        requestView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        
        responseView.translatesAutoresizingMaskIntoConstraints = false
        responseView.topAnchor.constraint(equalTo: requestView.bottomAnchor, constant: padding).isActive = true
        responseView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        responseView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        responseView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        
        update(buttonEnabled: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(errorResponse: String?) {
        responseView.text = errorResponse
    }
    
    func update(statusCode: HTTPStatusCode?, response: [String:Any]?) {
        requestView.update(statusCode: statusCode, response: response)
        responseView.attributedText = JSONHighlighter.format(json: response)
    }
    
    func update(buttonEnabled: Bool) {
        requestView.update(buttonEnabled: buttonEnabled)
    }
    
    func update(method: String?) {
        requestView.update(method: method)
    }
    
    func update(url: String?) {
        requestView.update(url: url)
    }
    
    func clearResponse() {
        update(statusCode: nil, response: nil)
    }
}

extension MainView: ToolbarViewDelegate {
    func importSelected() {
        delegate?.importSelected()
    }    
}

extension MainView: RequestViewDelegate {
    func send() {
        delegate?.send()
    }
    
    func showBodyView() {
        delegate?.showBodyView()
    }
    
    func showHeadersView() {
        delegate?.showHeadersView()
    }
    
    func showMethodPopover(sender: UIView) {
        delegate?.showMethodPopover(sender: sender)
    }
    
    func showResponseCodePopover(sender: UIView) {
        delegate?.showResponseCodePopover(sender: sender)
    }
    
    func urlChanged(_ url: String) {
        delegate?.urlChanged(url)
    }
    
    
}
