import UIKit

protocol RequestHeaderTableCellDelegate: class {
    func headerUpdated(_ header: Header, cell: UITableViewCell)
    func addRow(cell: UITableViewCell)
    func removeRow(cell: UITableViewCell)
}

class RequestHeaderTableCell: UITableViewCell {
    weak var delegate: RequestHeaderTableCellDelegate?
    
    fileprivate let keyTextField = UITextField()
    fileprivate let valueTextField = UITextField()
    fileprivate let removeRowButton = UIButton()
    private let textFieldStackView = UIStackView()
    var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        selectionStyle = .none
        
        let image = UIImage(named: "x-mark-3-128")
        removeRowButton.setImage(image, for: .normal)
        removeRowButton.addTarget(self, action: #selector(removeRowTapped), for: .touchUpInside)
        
        keyTextField.backgroundColor = .white
        keyTextField.placeholder = "Enter Key"
        keyTextField.autocorrectionType = .no
        keyTextField.keyboardType = .default
        keyTextField.layer.cornerRadius = 5
        keyTextField.clearButtonMode = .whileEditing
        keyTextField.autocapitalizationType = .none
        
        valueTextField.backgroundColor = .white
        valueTextField.placeholder = "Enter Value"
        valueTextField.autocorrectionType = .no
        valueTextField.keyboardType = .default
        valueTextField.layer.cornerRadius = 5
        valueTextField.clearButtonMode = .whileEditing
        valueTextField.autocapitalizationType = .none
        
        keyTextField.delegate = self
        valueTextField.delegate = self
        
        addSubview(textFieldStackView)
        addSubview(removeRowButton)
        
        textFieldStackView.addArrangedSubview(keyTextField)
        textFieldStackView.addArrangedSubview(valueTextField)
        textFieldStackView.setCustomSpacing(10, after: keyTextField)
        textFieldStackView.distribution = .fillEqually
        textFieldStackView.alignment = .center
        
        keyTextField.translatesAutoresizingMaskIntoConstraints = false
        keyTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        valueTextField.translatesAutoresizingMaskIntoConstraints = false
        valueTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        textFieldStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        textFieldStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        textFieldStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        textFieldStackView.trailingAnchor.constraint(equalTo: removeRowButton.leadingAnchor, constant: -10).isActive = true
        textFieldStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        removeRowButton.translatesAutoresizingMaskIntoConstraints = false
        removeRowButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        removeRowButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        removeRowButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        removeRowButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        keyTextField.text = nil
        valueTextField.text = nil
    }
    
    func set(key: String?) {
        keyTextField.text = key
    }
    
    func set(value: String?) {
        valueTextField.text = value
    }
    
    @objc
    func removeRowTapped() {
        delegate?.removeRow(cell: self)
    }
}

extension RequestHeaderTableCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let header = Header(key: keyTextField.text, value: valueTextField.text)
        delegate?.headerUpdated(header, cell: self)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.addRow(cell: self)
    }
}
