import UIKit

protocol MainRequestViewDelegate: class {
    func send()
    func showBodyView()
    func showHeadersView()
    func showMethodPopover(sender: UIView)
    func urlChanged(_ url: String)
}

class MainRequestView: UIView, UITextFieldDelegate {
    weak var delegate: MainRequestViewDelegate?
    
    private let toolbarView = ToolbarView()
    private let sendButton = UIButton()
    private let headersButton = UIButton()
    private let bodyButton = UIButton()
    private let responseCodeLabel = UILabel()
    private let responseTitleLabel = UILabel()
    private let stackView = UIStackView()
    private let responseView = UITextView()
    private let urlTextField = UITextField()
    private let requestTypePicker = UIPickerView()
    private let methodButton = UIButton()
    private let padding: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        toolbarView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
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
        
        responseView.font = UIFont.systemFont(ofSize: 20)
        responseView.isEditable = false
        
        addSubview(toolbarView)
        addSubview(sendButton)
        addSubview(responseView)
        addSubview(urlTextField)
        addSubview(methodButton)
        addSubview(stackView)
        addSubview(responseCodeLabel)
        addSubview(responseTitleLabel)
        
        stackView.addArrangedSubview(headersButton)
        stackView.addArrangedSubview(bodyButton)
        stackView.setCustomSpacing(10, after: headersButton)

        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        toolbarView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        toolbarView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        toolbarView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        toolbarView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        methodButton.translatesAutoresizingMaskIntoConstraints = false
        methodButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        methodButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        methodButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        methodButton.firstBaselineAnchor.constraint(equalTo: urlTextField.firstBaselineAnchor).isActive = true
        
        urlTextField.translatesAutoresizingMaskIntoConstraints = false
        urlTextField.topAnchor.constraint(equalTo: toolbarView.bottomAnchor, constant: padding).isActive = true
        urlTextField.leadingAnchor.constraint(equalTo: methodButton.trailingAnchor, constant: padding).isActive = true
        urlTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.leadingAnchor.constraint(equalTo: urlTextField.trailingAnchor, constant: padding).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        sendButton.firstBaselineAnchor.constraint(equalTo: urlTextField.firstBaselineAnchor).isActive = true
        
        headersButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        bodyButton.widthAnchor.constraint(equalToConstant: 100).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: methodButton.bottomAnchor, constant: padding).isActive = true
        
        responseCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        responseCodeLabel.trailingAnchor.constraint(equalTo: responseTitleLabel.leadingAnchor, constant: -padding).isActive = true
        responseCodeLabel.firstBaselineAnchor.constraint(equalTo: stackView.firstBaselineAnchor).isActive = true
//        responseCodeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        responseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        responseTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        responseTitleLabel.firstBaselineAnchor.constraint(equalTo: responseCodeLabel.firstBaselineAnchor).isActive = true
        
        responseView.translatesAutoresizingMaskIntoConstraints = false
        responseView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding).isActive = true
        responseView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        responseView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        responseView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        
        update(buttonEnabled: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubmitEnabled(_ enabled: Bool) {
        update(buttonEnabled: enabled)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            delegate?.urlChanged(updatedText)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        urlTextField.resignFirstResponder()
        sendButtonTapped()
        return true
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
    
    func update(errorResponse: String?) {
        responseView.text = errorResponse
    }
    
    func update(statusCode: Int?, response: Any?) {
        switch (statusCode, response) {
        case (.some(let statusCode), .none):
            responseCodeLabel.text = String(statusCode)
            responseTitleLabel.text = HTTPStatusCodes(rawValue: statusCode)?.responseTitle
        case (.none, .some(let response)):
            responseView.text = "\(response)"
        case (.some(let statusCode), .some(let response)):
            responseCodeLabel.text = String(statusCode)
            responseTitleLabel.text = HTTPStatusCodes(rawValue: statusCode)?.responseTitle
            responseView.text = "\(response)"
        default:
            responseView.text = ""
        }
    }
    
    func update(buttonEnabled: Bool) {
        sendButton.isEnabled = buttonEnabled
        sendButton.alpha = buttonEnabled ? 1 : 0.5
    }
    
    func update(method: String?) {
        methodButton.setTitle(method, for: .normal)
    }
}
