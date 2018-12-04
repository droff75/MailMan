import UIKit

class PostmanCollectionView: UIView {
    private let noCollectionsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        noCollectionsLabel.text = "You have not added any collections yet."
        noCollectionsLabel.textAlignment = .center
        noCollectionsLabel.numberOfLines = 0
        
        addSubview(noCollectionsLabel)
        
        noCollectionsLabel.translatesAutoresizingMaskIntoConstraints = false
        noCollectionsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        noCollectionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        noCollectionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
