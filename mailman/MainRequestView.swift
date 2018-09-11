import UIKit

protocol MainRequestViewDelegate: class {
    func send(requestData: RequestData)
    func valueChanged(requestData: RequestData)
    func showBodyView()
}

class MainRequestView: UIView, UITextFieldDelegate {
    weak var delegate: MainRequestViewDelegate?
    
    private let toolbarView = ToolbarView()
    private let sendButton = UIButton()
    private let headersButton = UIButton()
    private let bodyButton = UIButton()
    private let stackView = UIStackView()
    private let responseView = UITextView()
    private let urlTextField = UITextField()
    private let requestTypePicker = UIPickerView()
    private let methodTextField = UITextField()
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
        urlTextField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingChanged)
        
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
        
        methodTextField.inputView = requestTypePicker
        methodTextField.backgroundColor = .white
        methodTextField.text = "GET"
        methodTextField.textAlignment = .center
        methodTextField.font = UIFont.boldSystemFont(ofSize: 20)
        methodTextField.textColor = .orange
        methodTextField.layer.cornerRadius = 5
        
        responseView.font = UIFont.systemFont(ofSize: 20)
        
        requestTypePicker.selectRow(0, inComponent: 0, animated: false)
        
        requestTypePicker.dataSource = self
        requestTypePicker.delegate = self
        
        addSubview(toolbarView)
        addSubview(sendButton)
        addSubview(responseView)
        addSubview(urlTextField)
        addSubview(methodTextField)
        addSubview(stackView)
        
        stackView.addArrangedSubview(headersButton)
        stackView.addArrangedSubview(bodyButton)
        stackView.setCustomSpacing(10, after: headersButton)

        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        toolbarView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        toolbarView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        toolbarView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        toolbarView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        methodTextField.translatesAutoresizingMaskIntoConstraints = false
        methodTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        methodTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        methodTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        methodTextField.firstBaselineAnchor.constraint(equalTo: urlTextField.firstBaselineAnchor).isActive = true
        
        urlTextField.translatesAutoresizingMaskIntoConstraints = false
        urlTextField.topAnchor.constraint(equalTo: toolbarView.bottomAnchor, constant: padding).isActive = true
        urlTextField.leadingAnchor.constraint(equalTo: methodTextField.trailingAnchor, constant: padding).isActive = true
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
        stackView.topAnchor.constraint(equalTo: methodTextField.bottomAnchor, constant: padding).isActive = true
        
        responseView.translatesAutoresizingMaskIntoConstraints = false
        responseView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding).isActive = true
        responseView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        responseView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        responseView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        
        update(buttonEnabled: false)
    }
    

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.valueChanged(requestData: requestDataFromFields())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func requestDataFromFields() -> RequestData {
        let method = methodTypes[requestTypePicker.selectedRow(inComponent: 0)]
        return RequestData(
            url: urlTextField.text,
            method: method,
            body: nil
        )
    }
    
    @objc
    private func sendButtonTapped() {
        delegate?.send(requestData: requestDataFromFields())
    }
    
    @objc
    private func headersButtonTapped() {
        print("Headers Button was Tapped")
    }
    
    @objc
    private func bodyButtonTapped() {
        delegate?.showBodyView()
    }
    
    func update(errorResponse: String?) {
        responseView.text = errorResponse
    }
    
    func update(statusCode: String?, response: String?) {        
        switch (statusCode, response) {
        case (.some(let statusCode), .none):
            responseView.text = statusCode
        case (.none, .some(let response)):
            responseView.text = response
        case (.some(let statusCode), .some(let response)):
            responseView.text = "\(statusCode) \n\n \(response)"
        default:
            responseView.text = ""
        }
    }
    
    func update(buttonEnabled: Bool) {
        sendButton.isEnabled = buttonEnabled
        sendButton.alpha = buttonEnabled ? 1 : 0.5
    }
    
}

extension MainRequestView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return methodTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return methodTypes[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        methodTextField.text = methodTypes[row].rawValue
    }
}
