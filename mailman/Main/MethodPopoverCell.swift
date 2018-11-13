import UIKit

class MethodPopoverCell: UITableViewCell {
    let methodLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(methodLabel)
        
        methodLabel.translatesAutoresizingMaskIntoConstraints = false
        methodLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        methodLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        methodLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
    }
    
    func set(method: Method) {
        methodLabel.text = method.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
