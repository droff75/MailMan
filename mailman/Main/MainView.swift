import UIKit

protocol MainViewDelegate: RequestViewDelegate, PostmanCollectionViewDelegate {
    func importSelected()
}

class MainView: UIView, UITextFieldDelegate {
    weak var delegate: MainViewDelegate?
    
    private let toolbarView = ToolbarView()
    private let postmanCollectionView = PostmanCollectionView()
    private let contentView = UIView()
    private let requestView = RequestView()
    private let responseView = UITextView()
    private let padding: CGFloat = 10
    private let collectionViewWidth: CGFloat = 256
    fileprivate var constraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .black
        
        toolbarView.delegate = self
        requestView.delegate = self
        postmanCollectionView.delegate = self
        
        addSubview(toolbarView)
        addSubview(postmanCollectionView)
        addSubview(contentView)
        contentView.addSubview(requestView)
        contentView.addSubview(responseView)
        
        postmanCollectionView.isHidden = true
        
        let safeAreaMargins = self.safeAreaLayoutGuide
        
        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        toolbarView.topAnchor.constraint(equalTo: safeAreaMargins.topAnchor).isActive = true
        toolbarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        toolbarView.leadingAnchor.constraint(equalTo: safeAreaMargins.leadingAnchor).isActive = true
        toolbarView.trailingAnchor.constraint(equalTo: safeAreaMargins.trailingAnchor).isActive = true
        
        postmanCollectionView.translatesAutoresizingMaskIntoConstraints = false
        postmanCollectionView.topAnchor.constraint(equalTo: toolbarView.bottomAnchor).isActive = true
        postmanCollectionView.trailingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        postmanCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        postmanCollectionView.widthAnchor.constraint(equalToConstant: collectionViewWidth).isActive = true
        
        constraint = contentView.leadingAnchor.constraint(equalTo: safeAreaMargins.leadingAnchor)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: toolbarView.bottomAnchor).isActive = true
        constraint?.isActive = true
        contentView.trailingAnchor.constraint(equalTo: safeAreaMargins.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        requestView.translatesAutoresizingMaskIntoConstraints = false
        requestView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
        requestView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        requestView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        
        responseView.translatesAutoresizingMaskIntoConstraints = false
        responseView.topAnchor.constraint(equalTo: requestView.bottomAnchor, constant: padding).isActive = true
        responseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        responseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        responseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
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
    
    func update(postmanCollections: [PostmanCollection]) {
        postmanCollectionView.update(collections: postmanCollections)
    }
    
    func clearResponse() {
        update(statusCode: nil, response: nil)
    }
}

extension MainView: ToolbarViewDelegate {
    func importSelected() {
        delegate?.importSelected()
    }
    
    func showPostmanCollectionSelected() {
        guard let constraint = constraint else { return }
        if constraint.constant > 0 {
            constraint.constant = 0
        } else {
            constraint.constant = collectionViewWidth
        }
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layoutIfNeeded()
            if let strongSelf = self, strongSelf.postmanCollectionView.isHidden {
                strongSelf.postmanCollectionView.isHidden = false
            } else if let strongSelf = self {
                strongSelf.postmanCollectionView.isHidden = true
            }
        }
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

extension MainView: PostmanCollectionViewDelegate {
    func requestSelected(request: RequestData) {
        delegate?.requestSelected(request: request)
    }
}
