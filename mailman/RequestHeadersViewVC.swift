import UIKit

class RequestHeadersViewVC: UITableViewController {
    private let headerCellId = "requestHeadersCell"
    private let headerModel: HeadersModel
    fileprivate var headers: [String:String] = [:]
    
    init(headerModel: HeadersModel) {
        self.headerModel = headerModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        tableView.register(RequestHeaderTableCell.self, forCellReuseIdentifier: headerCellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: headerCellId, for: indexPath) as! RequestHeaderTableCell
        cell.delegate = self
        return cell
    }
}

extension RequestHeadersViewVC: RequestHeaderTableCellDelegate {
    func headerUpdated(_ header: Header, cell: UITableViewCell) {
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        
        headerModel.update(header: header, at: index)
    }
}
