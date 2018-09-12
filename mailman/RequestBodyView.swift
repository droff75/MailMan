import UIKit

protocol RequestBodyViewDelegate: class {
    func dismissBodyView()
    func bodyChanged(_ body: String)
}

class RequestBodyView: UIView {
    weak var delegate: RequestBodyViewDelegate?
    
    private let textView = UITextView()
    private let doneButton = UIButton()
    private let padding: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        doneButton.setTitle("DONE", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        doneButton.backgroundColor = .orange
        doneButton.layer.cornerRadius = 5
        
        self.addSubview(textView)
        self.addSubview(doneButton)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: topAnchor, constant: padding*2).isActive = true
        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        textView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -padding).isActive = true
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 100).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func doneButtonTapped() {
        delegate?.bodyChanged(textView.text)
        delegate?.dismissBodyView()
    }
    
}
