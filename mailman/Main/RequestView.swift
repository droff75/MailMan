import UIKit

protocol RequestViewDelegate: class {
    func send()
    func showBodyView()
    func showHeadersView()
    func showMethodPopover(sender: UIView)
    func showResponseCodePopover(sender: UIView)
    func urlChanged(_ url: String)
}

class RequestView: UIView {
    weak var delegate: RequestViewDelegate?

    private let methodButton = UIButton()
    private let urlTextField = UITextField()
    private let sendButton = UIButton()
    private let headersButton = UIButton()
    private let bodyButton = UIButton()
    private let buttonStackView = UIStackView()
    private let responseCodeLabel = UILabel()
    private let responseTitleLabel = UILabel()
    private let responseStackView = UIStackView()
    private let padding: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        urlTextField.backgroundColor = .white
        urlTextField.placeholder = "Enter URL"
        urlTextField.autocorrectionType = .no
        urlTextField.keyboardType = .URL
        urlTextField.layer.cornerRadius = 5
        urlTextField.clearButtonMode = .whileEditing
        urlTextField.autocapitalizationType = .none
        
        urlTextField.delegate = self
        
        sendButton.setTitle("SEND", for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        sendButton.backgroundColor = .orange
        sendButton.layer.cornerRadius = 5
        
        headersButton.setTitle("HEADERS", for: .normal)
        headersButton.addTarget(self, action: #selector(headersButtonTapped), for: .touchUpInside)
        headersButton.backgroundColor = .orange
        headersButton.layer.cornerRadius = 5
        
        bodyButton.setTitle("BODY", for: .normal)
        bodyButton.addTarget(self, action: #selector(bodyButtonTapped), for: .touchUpInside)
        bodyButton.backgroundColor = .orange
        bodyButton.layer.cornerRadius = 5
        
        responseCodeLabel.font = UIFont.systemFont(ofSize: 20)
        responseCodeLabel.textColor = UIColor.green
        
        responseTitleLabel.font = UIFont.systemFont(ofSize: 20)
        responseTitleLabel.textColor = .white
        
        methodButton.addTarget(self, action: #selector(methodButtonTapped), for: .touchUpInside)
        methodButton.setTitle("GET", for: .normal)
        methodButton.backgroundColor = .orange
        methodButton.layer.cornerRadius = 5
        
        addSubview(methodButton)
        addSubview(urlTextField)
        addSubview(sendButton)
        addSubview(buttonStackView)
        addSubview(responseStackView)
        
        buttonStackView.addArrangedSubview(headersButton)
        buttonStackView.addArrangedSubview(bodyButton)
        buttonStackView.setCustomSpacing(10, after: headersButton)
        
        responseStackView.addArrangedSubview(responseCodeLabel)
        responseStackView.addArrangedSubview(responseTitleLabel)
        responseStackView.setCustomSpacing(10, after: responseCodeLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(responseCodeTapped))
        responseStackView.addGestureRecognizer(gesture)
        
        methodButton.translatesAutoresizingMaskIntoConstraints = false
        methodButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        methodButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        methodButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        methodButton.firstBaselineAnchor.constraint(equalTo: urlTextField.firstBaselineAnchor).isActive = true
        
        urlTextField.translatesAutoresizingMaskIntoConstraints = false
        urlTextField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        urlTextField.leadingAnchor.constraint(equalTo: methodButton.trailingAnchor, constant: padding).isActive = true
        urlTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.leadingAnchor.constraint(equalTo: urlTextField.trailingAnchor, constant: padding).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sendButton.firstBaselineAnchor.constraint(equalTo: urlTextField.firstBaselineAnchor).isActive = true
        
        headersButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        bodyButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        buttonStackView.topAnchor.constraint(equalTo: methodButton.bottomAnchor, constant: padding).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        responseStackView.translatesAutoresizingMaskIntoConstraints = false
        responseStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        responseStackView.firstBaselineAnchor.constraint(equalTo: buttonStackView.firstBaselineAnchor).isActive = true
        
        update(buttonEnabled: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(buttonEnabled: Bool) {
        sendButton.isEnabled = buttonEnabled
        sendButton.alpha = buttonEnabled ? 1 : 0.5
    }
    
    func update(statusCode: HTTPStatusCode?, response: [String:Any]?) {
        switch (statusCode, response) {
        case (.some(let statusCode), .none):
            responseCodeLabel.text = String(statusCode.rawValue)
            responseTitleLabel.text = statusCode.responseTitle
        case (.none, .some):
            responseCodeLabel.text = nil
            responseTitleLabel.text = nil
        case (.some(let statusCode), .some):
            responseCodeLabel.text = String(statusCode.rawValue)
            responseTitleLabel.text = statusCode.responseTitle
        default:
            responseCodeLabel.text = nil
            responseTitleLabel.text = nil
        }
    }
    
    func update(method: String?) {
        methodButton.setTitle(method, for: .normal)
    }
    
    func update(url: String?) {
        urlTextField.text = url
    }
    
    @objc
    private func sendButtonTapped() {
        delegate?.send()
    }
    
    @objc
    private func headersButtonTapped() {
        delegate?.showHeadersView()
    }
    
    @objc
    private func bodyButtonTapped() {
        delegate?.showBodyView()
    }
    
    @objc
    private func methodButtonTapped() {
        delegate?.showMethodPopover(sender: methodButton)
    }
    
    @objc
    private func responseCodeTapped() {
        delegate?.showResponseCodePopover(sender: responseCodeLabel)
    }
}

extension RequestView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            delegate?.urlChanged(updatedText)
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        delegate?.urlChanged("")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        urlTextField.resignFirstResponder()
        sendButtonTapped()
        return true
    }
}
