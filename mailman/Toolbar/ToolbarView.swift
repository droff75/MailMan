import UIKit
import MobileCoreServices

protocol ToolbarViewDelegate: class {
    func importSelected()
    func showPostmanCollectionSelected()
}

class ToolbarView: UIView {
    weak var delegate: ToolbarViewDelegate?
    
    private let collectionButton = UIButton()
    private let importButton = UIButton()
    private let stackView = UIStackView()
    private let labelView = UILabel()
    private var collectionImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        if UIDevice.current.model == "iPhone" {
            collectionImage = UIImage(named: "icons8-chevron-right-filled-50")
            let importImage = UIImage(named: "icons8-download-50")
            collectionButton.setImage(collectionImage, for: .normal)
            collectionButton.imageView?.contentMode = .scaleAspectFit
            
            importButton.setImage(importImage, for: .normal)
            importButton.imageView?.contentMode = .scaleAspectFit
            
            collectionButton.translatesAutoresizingMaskIntoConstraints = false
            collectionButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            
            importButton.translatesAutoresizingMaskIntoConstraints = false
            importButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        } else {
            collectionButton.backgroundColor = .orange
            collectionButton.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
            collectionButton.setTitle("Collections", for: .normal)
            collectionButton.layer.cornerRadius = 5

            importButton.backgroundColor = .orange
            importButton.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
            importButton.setTitle("Import", for: .normal)
            importButton.layer.cornerRadius = 5
        }
        
        collectionButton.addTarget(self, action: #selector(collectionButtonTapped), for: .touchUpInside)
        
        importButton.addTarget(self, action: #selector(importButtonTapped), for: .touchUpInside)

        labelView.text = "MailMan"
        labelView.textColor = .white
        labelView.font = UIFont.systemFont(ofSize: 30)
        
        addSubview(labelView)
        addSubview(stackView)
        
        stackView.addArrangedSubview(collectionButton)
        stackView.addArrangedSubview(importButton)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func collectionButtonTapped() {
        if UIDevice.current.model == "iPhone" {
            if collectionImage == UIImage(named: "icons8-chevron-left-filled-50") {
                collectionImage = UIImage(named: "icons8-chevron-right-filled-50")
                collectionButton.setImage(collectionImage, for: .normal)
            } else {
                collectionImage = UIImage(named: "icons8-chevron-left-filled-50")
                collectionButton.setImage(collectionImage, for: .normal)
            }
        }
        delegate?.showPostmanCollectionSelected()
    }
    
    @objc
    private func importButtonTapped() {
        delegate?.importSelected()
    }    
}
