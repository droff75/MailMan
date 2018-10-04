import UIKit

protocol RequestHeaderFooterViewDelegate: class {
    func dismissHeaderView()
    func updateHeaders()
}

class RequestHeaderFooterView: UITableViewHeaderFooterView {
    weak var delegate: RequestHeaderFooterViewDelegate?

    private let doneButton = UIButton()
    private let cancelButton = UIButton()
    private let stackView = UIStackView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        doneButton.setTitle("DONE", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        doneButton.backgroundColor = .orange
        doneButton.layer.cornerRadius = 5
        
        cancelButton.setTitle("CANCEL", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        cancelButton.backgroundColor = .orange
        cancelButton.layer.cornerRadius = 5
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(doneButton)
        stackView.setCustomSpacing(10, after: cancelButton)
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func doneButtonTapped() {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        delegate?.updateHeaders()
        delegate?.dismissHeaderView()
    }
    
    @objc
    func cancelButtonTapped() {
        delegate?.dismissHeaderView()
    }
}
