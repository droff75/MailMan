import UIKit

protocol MethodPopoverViewControllerDelegate: class {
    func update(method: Method)
}

class MethodPopoverViewController: UITableViewController {
    private let methodCellId = "methodPopoverCell"
    weak var delegate: MainRequestViewController?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        tableView.register(MethodPopoverCell.self, forCellReuseIdentifier: methodCellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Method.types.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: methodCellId, for: indexPath) as! MethodPopoverCell
        let method = Method.types[indexPath.row]
        cell.set(method: method)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let method = Method.types[indexPath.row]
        delegate?.update(method: method)
        self.dismiss(animated: true, completion: nil)
    }
    
}

