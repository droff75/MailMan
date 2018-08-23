import UIKit

class MainRequestView: UIView {
    
    
//    private let mainView = UIView()
    private let toolbarView = ToolbarView()
    private let sendButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        toolbarView.backgroundColor = .black
        
        sendButton.setTitle("SEND", for: .normal)
        sendButton.backgroundColor = .gray
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        addSubview(toolbarView)
        addSubview(sendButton)
        
        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        toolbarView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        toolbarView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        toolbarView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        toolbarView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
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
    
    private func completion(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if let error = error {
            print(error)
        } else if let data = data {
            print(String(data: data, encoding: .utf8))
        }
    }
}
