import UIKit

protocol PostmanCollectionViewDelegate: class {
    func requestSelected(at indexPath: IndexPath)
}

class PostmanCollectionView: UIView {
    weak var delegate: PostmanCollectionViewDelegate?
    
    private let noCollectionsLabel = UILabel()
    private let tableView = UITableView()
    private var collections: [PostmanCollection] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        noCollectionsLabel.text = "You have not added any collections yet."
        noCollectionsLabel.textAlignment = .center
        noCollectionsLabel.numberOfLines = 0
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubview(noCollectionsLabel)
        addSubview(tableView)
        
        noCollectionsLabel.translatesAutoresizingMaskIntoConstraints = false
        noCollectionsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        noCollectionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        noCollectionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(collections: [PostmanCollection]) {
        self.collections = collections
        updateView()
    }
    
    private func updateView() {
        tableView.isHidden = collections.count == 0
        tableView.reloadData()
    }
}

extension PostmanCollectionView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))!
        cell.textLabel?.text = collections[indexPath.section].item[indexPath.row].name
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = collections.count
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections[section].item.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return collections[section].info.name
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.requestSelected(at: indexPath)
    }
}
