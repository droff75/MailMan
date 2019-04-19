import UIKit

protocol RequestBodyViewDelegate: class {
    func bodyChanged(_ body: String)
}

class RequestBodyView: UIView {
    weak var delegate: RequestBodyViewDelegate?
    
    private let textView = UITextView()
    private let padding: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        textView.delegate = self
        
        self.addSubview(textView)
        
        textView.font = UIFont.systemFont(ofSize: 20)
    
        let margins = self.safeAreaLayoutGuide
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: margins.topAnchor, constant: padding*2).isActive = true
        textView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        textView.becomeFirstResponder()
    }
    
    func set(body: String?) {
        textView.text = body
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RequestBodyView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let viewText = textView.text, let textRange = Range(range, in: viewText) else {
            return true
        }
        
        let updatedText = viewText.replacingCharacters(in: textRange, with: text)
        
        delegate?.bodyChanged(updatedText)
        
        return true
    }
}


