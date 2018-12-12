import UIKit

protocol PostmanCollectionViewDelegate: class {
    func requestSelected(request: RequestData)
}

class PostmanCollectionView: UIView {
    weak var delegate: PostmanCollectionViewDelegate?
    
    private let noCollectionsLabel = UILabel()
    private let tableView = UITableView()
    fileprivate var viewModel: PostmanCollectionViewModel?
    
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
        viewModel = PostmanCollectionViewModel(postmanCollections: collections)
        updateView()
    }
    
    private func updateView() {
        tableView.isHidden = viewModel == nil
        tableView.reloadData()
    }
}

extension PostmanCollectionView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))!
        if let rowData = viewModel?.data(for: indexPath) {
            let indentSpaces = Array(repeating: " ", count: rowData.indent * 4).joined()
            cell.textLabel?.text = indentSpaces + rowData.name
            if case RowType.folder(_) = rowData.type {
                cell.backgroundColor = .lightGray
            } else {
                cell.backgroundColor = .white
            }
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.title(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let rowData = viewModel?.data(for: indexPath) {
            if case RowType.request(let postmanRequest) = rowData.type {
                delegate?.requestSelected(request: postmanRequest.request)
            } else {
                //do folder thing
            }
        }
    }
}
