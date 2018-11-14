import UIKit

class TextPopoverView: UIView {
    private let definitionTextView = UITextView()
    
    init(text: String?) {
        super.init(frame: .zero)
        
        addSubview(definitionTextView)
        
        definitionTextView.isEditable = false
        definitionTextView.isScrollEnabled = true
        definitionTextView.font = UIFont.systemFont(ofSize: 15)
        definitionTextView.backgroundColor = .clear
        definitionTextView.text = text
        
        let padding: CGFloat = 10
        
        definitionTextView.translatesAutoresizingMaskIntoConstraints = false
        definitionTextView.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        definitionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        definitionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        definitionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
