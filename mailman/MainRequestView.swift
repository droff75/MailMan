import UIKit

class MainRequestView: UIView {
    
    
//    private let mainView = UIView()
    private let toolbarView = ToolbarView()
    private let sendButton = UIButton()
    private let responseView = UITextView()
    private let padding: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        toolbarView.backgroundColor = .black
        
        sendButton.setTitle("SEND", for: .normal)
        sendButton.backgroundColor = .gray
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        addSubview(toolbarView)
        addSubview(sendButton)
        addSubview(responseView)
        
        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        toolbarView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        toolbarView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        toolbarView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        toolbarView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: toolbarView.bottomAnchor, constant: padding).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        responseView.translatesAutoresizingMaskIntoConstraints = false
        responseView.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: padding).isActive = true
        responseView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        responseView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        responseView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func sendButtonTapped() {
        print("I tapped the SEND button")
        sendRequest()
        
        
    }
    
    private func sendRequest() {
        guard let url = URL(string: "https://postman-echo.com/get?test=MyMessage") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: completion)
        dataTask.resume()
    }
    
    private func handleData(_ data: Data?) {
        guard let data = data else { return }
        DispatchQueue.main.async { [weak self] in
            let stringData = String(data: data, encoding: .utf8)
            self?.responseView.text = stringData
        }
    }
    
    private func completion(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if let error = error {
            print(error)
        } else {
            handleData(data)
        }
    }
}
